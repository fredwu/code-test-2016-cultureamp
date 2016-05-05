module Surveyor
  class CLI
    class << self
      def options
        @options ||= {}
      end

      def run
        Parser.run
        Workflow.run(**options)
      end
    end
  end
end
