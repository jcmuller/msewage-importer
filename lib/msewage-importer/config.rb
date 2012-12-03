require "hashie"
require "yaml"

module Msewage::Importer
  class Config
    def initialize(options)
      setup_config(options)
      validate_config
    end

    def api_endpoint
      API_ENDPOINT
    end

    private

    attr_reader :config

    API_ENDPOINT = "http://data.mwater.co/msewage/apiv2"

    def setup_config(options)
      options_from_config = config_file(config_file_path(options))
      @config = Hashie::Mash.new
      config.merge!(options_from_config) unless options_from_config.nil?
      config.merge!(options)
    end

    def config_file_path(options)
      options.delete(:config_file_path) || default_config_file_path
    end

    def validate_config
      unless valid_keys?
        STDERR.puts "Please create a config file in #{default_config_file_path}"
        STDERR.puts "\nIt should look like:\n\n#{config_file_example}"

        exit 1
      end
    end

    def valid_keys?
      config[:msewage] && config.msewage[:username] && config.msewage[:password]
    end

    def default_config_file_path
      "#{ENV['HOME']}/.config/msewage-importer/config.yml"
    end

    def config_file(config_file_path)
      YAML.load_file(config_file_path)
    rescue Errno::ENOENT
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
