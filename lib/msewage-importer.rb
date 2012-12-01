require "msewage-importer/version"

module Msewage::Importer
  autoload :CLI, 'msewage-importer/cli'
  autoload :Config, 'msewage-importer/config'
  autoload :Geolocator, 'msewage-importer/geolocator'
  autoload :Importer, 'msewage-importer/importer'
  autoload :Importers, 'msewage-importer/importers'
end
