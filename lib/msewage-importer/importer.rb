require 'uuid'

module Msewage::Importer
  class Importer
    class NoTypeSpecified < RuntimeError
      def initialize; super("No type of import specified"); end
    end

    class NoSourceSpecified < RuntimeError
      def initialize; super("No source file to import specified"); end
    end

    class InvalidTypeSpecified < RuntimeError
      def initialize; super("Invalid import type specified"); end
    end

    def initialize(options)
      puts options.inspect
      @config = Config.new(options[:config])
      config.override(options)
    end

    def import
      assert
      importer = source_importer
      sources = importer.import
      import_sources(sources)
    rescue NoTypeSpecified, NoSourceSpecified, InvalidTypeSpecified => e
      STDERR.puts e
      exit
    end

    private

    attr_reader :config, :api

    def geolocator
      @geolocator ||= Geolocator.new(config)
    end

    def api
      @api ||= API.new(config)
    end

    def ensure_coordinates(source)
      unless source["latitude"] && source["longitude"]
        coordinates = geolocator.geolocate(source["location"])
        source["latitude"], source["longitude"] = coordinates
      end
      source
    end

    def add_source_type(source)
      source["source_type"] = source_type
      source
    end

    def source_importer
      Importers::Base.factory(config.source)
    end

    def import_sources(sources)
      sources.each do |source|
        import_source(source)
      end
      puts
    end

    def import_source(source)
      ensure_coordinates(source)
      add_source_type(source)
      unless api.insert(source)
        STDERR.puts "Error inserting #{source.inspect}"
      end
    end

    def assert
      raise NoTypeSpecified unless config_option(:type)
      raise InvalidTypeSpecified unless valid_type?
      raise NoSourceSpecified unless config_option(:source)
    end

    def config_option(option)
      config.send(:config).send(:[], option)
    end

    def source_type
      SourceTypes.given_type_to_apis(config.type)
    end

    def valid_type?
      !!source_type
    end
  end
end
