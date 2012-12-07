require 'uuid'
require 'httparty'

module Msewage::Importer
  class API
    def initialize(config = Config.new)
      @config = config
    end

    def insert(record)
      res = HTTParty.put(new_source_url, :body => new_source_body(record))
      !res["code"].nil?
      print "."
    end

    private

    def new_source_url
      "#{api_endpoint}/sources/#{source_uid}?clientuid=#{client_uid}"
    end

    def new_source_body(record)
      {
        :created_by => user_name,
        :desc => record["desc"] || record["description"],
        :latitude => record["latitude"] || record["lat"],
        :longitude => record["longitude"] || record["lon"],
        :name => record["name"],
        :source_type => record["source_type"]
      }
    end

    def client_uid
      @client_uid ||= retrieve_client_uid
    end

    def retrieve_client_uid
      body = { :password => password }
      path = "#{api_endpoint}/users/#{user_name}"
      res = HTTParty.post(path, :body => body)
      res["clientuid"]
    end

    attr_reader :config

    def source_uid
      UUID.generate.gsub(/-/, '')
      #"0" * 16
    end

    def user_name
      config.msewage.username
    end

    def password
      config.msewage.password
    end

    def api_endpoint
      config.api_endpoint
    end
  end
end
