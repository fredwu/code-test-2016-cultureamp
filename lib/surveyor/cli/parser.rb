require 'optparse'

module Surveyor
  class CLI
    class Parser
      def self.run
        OptionParser.new do |opts|
          opts.banner = 'Example usage:'

          opts.on('-s', '--survey FILE', 'Survey data input file') do |opt|
            CLI.options[:survey_file_path] = opt
          end

          opts.on('-r', '--responses FILE', 'Responses data input file') do |opt|
            CLI.options[:responses_file_path] = opt
          end
        end.parse!
      end
    end
  end
end
