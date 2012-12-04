require 'geocoder'

# TODO
# use http://www.geonames.org/
module Msewage::Importer
  class Geolocator
    def initialize(config = Config.new)
      #Geocoder.configure do |c|
      #  #c.lookup = :bing
      #  #c.api_key = config.geocoder.bing_key
      #  c.lookup = :google
      #  #c.lookup = :nominatim
      #  #c.lookup = :yandex
      #  #c.lookup = :mapquest
      #  #c.lookup = :freegeoip
      #end

      @config = config
    end

    def geolocate(location)
      result = Geocoder.search(location)
      result = result.first if result.is_a?(Array)
      result.nil? ? nil : result.coordinates
    end

    private

    attr_reader :config
  end
end
