require 'getoptlong'
require 'command_line_helper'

module Msewage::Importer
  class CLI
    include CommandLineHelper::HelpText

    class << self
      def run
        self.new.setup_and_run
      end
    end

    def setup_and_run
      setup
      run
    end

    private

    attr_reader :options

    def setup
      set_program_name
      process_command_line_options
    rescue GetoptLong::MissingArgument, GetoptLong::InvalidOption, GetoptLong::AmbiguousOption
      puts
      puts "Run #{program_name} --help to see the available options"
      exit
    end

    def run
      Importer.new(options).import
    end

    def options_possible
      [
        ['--config',  '-c', GetoptLong::REQUIRED_ARGUMENT, 'Override the configuration file'],
        ['--help',    '-h', GetoptLong::NO_ARGUMENT,       'Show this text'],
        ['--source',  '-s', GetoptLong::REQUIRED_ARGUMENT, 'Source file with data to import'],
        ['--type',    '-t', GetoptLong::REQUIRED_ARGUMENT, 'Type of defecation site sources to import'],
        ['--types',   '-T', GetoptLong::NO_ARGUMENT,       'Show type of defecation sites available'],
        ['--verbose', '-v', GetoptLong::NO_ARGUMENT,       'Be extremely verbose'],
        ['--version', '-V', GetoptLong::NO_ARGUMENT,       'Show version info'],
      ]
    end

    def process_command_line_options
      @options = {}

      cli_options.each do |opt, arg|
        case opt
        when '--help'
          show_help_and_exit
        when '--config'
          options[:config] = arg
        when '--verbose'
          options[:verbose] = true
        when '--version'
          show_version_info_and_exit
        when '--types'
          show_types_and_exit
        when '--type'
          options[:type] = arg
        when '--source'
          options[:source] = arg
        end
      end
    end

    def cli_options
      @cli_options ||= GetoptLong.new(*options_possible.map{ |o| o.first(3) })
    end

    def show_types_and_exit
      puts "  " << SourceTypes.types_supported * "\n  "
      exit
    end

    def show_version_info_and_exit
      puts version_info
      exit
    end

    def version_info
      <<-EOV
#{program_name}, version #{version}

(c) Juan C. Muller, 2012
http://github.com/jcmuller/msewage-importer
  EOV
    end

    def version
      VERSION
    end

    def show_help_and_exit
      STDOUT.puts help_info
      exit
    end

    def set_program_name
      $0 = "#{File.basename($0)} (#{version})"
    end
  end
end
