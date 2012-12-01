require 'json'

module Msewage::Importer
  module Importers
    class JSON < Base
      type :json

      def import
        puts "Loading #{file_name}"
        puts ::JSON.parse(File.read(file_name))
      end
    end
  end
end
