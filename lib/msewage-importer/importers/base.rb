module Msewage::Importer
  module Importers
    class Base

      class << self
        def type(*file_types)
          file_types.each do |file_type|
            Importers::Base.importers[file_type] = self
          end
        end

        def factory(file_name)
          load_importers
          importers.each_pair do |extension, class_name|
            if file_name =~ %r{#{extension}}
              return class_name.new(file_name)
            end
          end
        end

        def load_importers
          dirname = File.dirname(__FILE__)
          Dir[File.join(dirname, "*.rb")].each do |f|
            require f.gsub(%r{#{dirname}/lib/}, '').gsub(/.rb/, '') unless f =~ /base/
          end
        end

        def importers
          @importers ||= {}
        end
      end

      def initialize(file_name)
        @file_name = file_name
      end

      def import
        raise "OVERRIDE ME"
      end

      private

      attr_reader :file_name

    end
  end
end
