require "msewage-importer/version"

module Msewage::Importer
  autoload :API, 'msewage-importer/api'
  autoload :CLI, 'msewage-importer/cli'
  autoload :Config, 'msewage-importer/config'
  autoload :Geolocator, 'msewage-importer/geolocator'
  autoload :Importer, 'msewage-importer/importer'
  autoload :SourceTypes, 'msewage-importer/source_types'

  module Importers
    autoload :Base, 'msewage-importer/importers/base'
    autoload :JSON, 'msewage-importer/importers/json'
    autoload :CSV, 'msewage-importer/importers/csv'
  end
end
