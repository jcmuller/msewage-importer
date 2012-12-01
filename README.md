# Msewage::Importer

Command line tool to import a CSV file into mSewage (msewage.org)

## Installation

    $ gem install msewage-importer

## Usage

    $ msewage-importer -T[source_type] [source.json]

Currently, the following source types are supported:
* open_defecation_site
* toilet
* latrine
* septic_tank
* sewage_outflow
* manure
* industrial_waste
* open_sewage

## Help

    $ msewage-importer --help

## Type of data supported

At this moment, only JSON data sources are supported. These sources should conform to the
following format [mSewage API](http://data.mwater.co/msewage/apiv2#2)

```json
{
  "sources": [
    {
      "name": "optional",
      "description": "optional",
      "location": "location string. Required."
    },
    ...
  ]
}

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
