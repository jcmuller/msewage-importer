# Msewage::Importer

Command line tool to import a CSV file into mSewage (msewage.org). It is able to import one
kind of source at a time.

## Installation

    $ gem install msewage-importer

## Usage

    $ msewage-importer --type [source_type] --source [source.json]

Currently, the following source types are supported:
* animal_manure
* combined_sewer_outflow
* industrial_waste_outflow
* latrine
* open_defecation_site
* open_sewage_canal_or_puddle
* raw_sewage_outflow
* septic_tank_cesspool
* toilet
* treatment_plant_outflow

## Help

    $ msewage-importer --help

## Type of data supported

At this moment, only JSON and CSV data sources are supported. These sources should conform to the
following format [mSewage API](http://data.mwater.co/msewage/apiv2#2)

The entries might already be geocoded. If they aren't, we will attempt to do so.

The data might come from a script like [this one](https://github.com/tlevine/pri-toilet-hackers).

### JSON
```json
{
  "sources": [
    {
      // Type with a location string that will be geocoded
      "name": "optional",
      "desc": "optional",
      "location": "location string. "
    },
    {
      // Type that will not be geocoded
      "name": "optional",
      "desc": "optional",
      "latitude": 0.00000,
      "longitude": 0.00000
    }
    ...
  ]
}
```

### CSV

```csv
name,desc,location
Optional name,Optional description,"Some place, some town, some country"
```

or

```csv
name,desc,latitude,longitude
Optional name,Optional description,0.0000,0.0000
```

The heading row is *required*.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
