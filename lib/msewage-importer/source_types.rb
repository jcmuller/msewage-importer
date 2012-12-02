module Msewage::Importer
  class SourceTypes
    class << self
      def given_type_to_apis(type)
        source_types[internal_types_to_msewages[type]]
      end

      def types_supported
        %w{
          animal_manure
          combined_sewer_outflow
          industrial_waste_outflow
          latrine
          open_defecation_site
          open_sewage_canal_or_puddle
          raw_sewage_outflow
          septic_tank_cesspool
          toilet
          treatment_plant_outflow
        }.sort
      end

      def internal_types_to_msewages
        {
          "open_defecation_site" => "Open defecation site",
          "toilet" => "Toilet",
          "latrine" => "Latrine",
          "septic_tank_cesspool" => "Septic tank/cesspool",
          "raw_sewage_outflow" => "Raw sewage outflow",
          "treatment_plant_outflow" => "Treatment plant outflow",
          "combined_sewer_outflow" => "Combined sewer outflow",
          "animal_manure" => "Animal manure",
          "industrial_waste_outflow" => "Industrial waste outflow",
          "open_sewage_canal_or_puddle" => "Open sewage canal or puddle"
        }
      end

      def source_types
        {
          "Open defecation site" => 0,
          "Toilet" => 1,
          "Latrine" => 2,
          "Septic tank/cesspool" => 3,
          "Raw sewage outflow" => 4,
          "Treatment plant outflow" => 5,
          "Combined sewer outflow" => 6,
          "Animal manure" => 7,
          "Industrial waste outflow" => 8,
          "Open sewage canal or puddle" => 9
        }
      end
    end
  end
end
