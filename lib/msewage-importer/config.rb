require "hashie"
require "yaml"

module Msewage::Importer
  class Config
    def initialize(path = default_config_file_path)
      @config = Hashie::Mash.new(config_file(path))
    end

    def valid?
      # TODO
    end

    def override(options = {})
      @config.merge!(options)
    end

    def api_endpoint
      API_ENDPOINT
    end

    private

    attr_reader :config

    API_ENDPOINT = "http://data.mwater.co/msewage/apiv2"

    def default_config_file_path
      "#{ENV['HOME']}/.config/msewage-importer/config.yml"
    end

    def config_file(config_file_path)
      YAML.load_file(config_file_path)
    rescue Errno::ENOENT
      STDERR.puts "Please create a config file in #{default_config_file_path}"
      STDERR.puts "\nIt should look like:\n\n#{config_file_example}"

      exit 1
    end

    def config_file_example
      File.read(config_file_example_path)
    end

    def config_file_example_path
      File.expand_path('../../../config/config-example.yml', __FILE__)
    end

    def method_missing(meth, *args, &block)
      return config[meth.to_s] if config.has_key?(meth.to_s)
      super
    end

    def respond_to?(meth)
      config.has_key?(meth.to_s) || super
    end
  end
end
