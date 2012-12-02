require 'json'

module Msewage::Importer
  module Importers
    class JSON < Base
      type :json

      def import
        ::JSON.parse(File.read(file_name))["sources"]
      end
    end
  end
end
