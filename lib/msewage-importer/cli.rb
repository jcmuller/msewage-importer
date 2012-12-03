require 'getoptlong'
require 'command_line_helper'

module Msewage::Importer
  # Public: Entry point for command line interface
  class CLI
    include CommandLineHelper::HelpText

    class << self
      # Public: entry point for class
      def run
        self.new.setup_and_run
      end
    end

    # Public: setup and run
    def setup_and_run
      setup
      run
    end

    private

    attr_reader :options

    # Private: set up program name and process command line options
    def setup
      process_command_line_options
    rescue GetoptLong::MissingArgument, GetoptLong::InvalidOption, GetoptLong::AmbiguousOption
      puts
      puts "Run #{program_name} --help to see the available options"
      exit
    end

    # Private: do some more!
    def run
      Importer.new(options).import
    end

    # Private: Command line options
    def options_possible
      [
        ['--config',  '-c', GetoptLong::REQUIRED_ARGUMENT, 'Override the configuration file'],
        ['--help',    '-h', GetoptLong::NO_ARGUMENT,       'Show this text'],
        ['--password', '-p', GetoptLong::REQUIRED_ARGUMENT, 'mSewage.org password'],
        ['--source',  '-s', GetoptLong::REQUIRED_ARGUMENT, 'Source file with data to import'],
        ['--type',    '-t', GetoptLong::REQUIRED_ARGUMENT, 'Type of defecation site sources to import'],
        ['--types',   '-T', GetoptLong::NO_ARGUMENT,       'Show type of defecation sites available'],
        ['--username', '-u', GetoptLong::REQUIRED_ARGUMENT, 'mSewage.org user name'],
        ['--verbose', '-v', GetoptLong::NO_ARGUMENT,       'Be extremely verbose'],
        ['--version', '-V', GetoptLong::NO_ARGUMENT,       'Show version info'],
      ]
    end

    # Private:
    def process_command_line_options
      @options = {}

      cli_options.each do |opt, arg|
        case opt
        when '--help'
          show_help_and_exit
        when '--config'
          options[:config_file_path] = arg
        when '--verbose'
          options[:verbose] = true
        when '--version'
          show_version_info_and_exit
        when '--types'
          show_types_and_exit
        when '--type'
          options[:type] = arg
        when '--username'
          options[:msewage] ||= {}
          options[:msewage][:username] = arg
        when '--password'
          options[:msewage] ||= {}
          options[:msewage][:password] = arg
        when '--source'
          options[:source] = arg
        end
      end
    end

    # Private:
    def cli_options
      @cli_options ||= GetoptLong.new(*options_possible.map{ |o| o.first(3) })
    end

    # Private:
    def show_types_and_exit
      puts "  " << SourceTypes.types_supported * "\n  "
      exit
    end

    # Private:
    def show_version_info_and_exit
      puts version_info
      exit
    end

    # Private:
    def version_info
      <<-EOV
#{program_name}, version #{version}

(c) Juan C. Muller, 2012
http://github.com/jcmuller/msewage-importer
  EOV
    end

    # Private:
    def version
      VERSION
    end

    # Private:
    def show_help_and_exit
      STDOUT.puts help_info
      exit
    end

  end
end
