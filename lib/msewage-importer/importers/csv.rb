require 'csv'

module Msewage::Importer
  module Importers
    class CSV < Base
      type :csv

      def import
        sources = read_file
        headers = sources.shift
        build_hash(headers, sources)
      end

      def read_file
        ::CSV.parse(File.read(file_name))
      end

      def build_hash(headers, sources)
        [].tap do |array_with_sources|
          sources.each_with_object({}) do |line, source|
            line.each_with_index do |data, i|
              source[headers[i]] = data
            end
            array_with_sources.push(source)
          end
        end
      end
    end
  end
end
