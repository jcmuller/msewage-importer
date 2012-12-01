module Msewage::Importer
  class Importer
    class NoTypeSpecified < RuntimeError
      def initialize; super("No type of import specified"); end
    end

    class NoSourceSpecified < RuntimeError
      def initialize; super("No source file to import specified"); end
    end

    def initialize(options)
      puts options.inspect
      @config = Config.new(options[:config])
      config.override(options)
    end

    def import
      assert
      importer = source_importer
      importer.import()
    rescue NoTypeSpecified, NoSourceSpecified => e
      STDERR.puts e
      exit
    end

    private

    attr_reader :config

    def source_importer
      Importers::Base.factory(config.source)
    end

    def assert
      raise NoTypeSpecified unless config_option(:type)
      raise NoSourceSpecified unless config_option(:source)
    end

    def config_option(option)
      config.send(:config).send(:[], option)
    end
  end
end
