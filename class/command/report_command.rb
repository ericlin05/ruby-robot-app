
require 'class/command/abstract_command'

# This class supports the "report" command
class ReportCommand < AbstractCommand
    def initialize(command, report)
        super(command)

        @report = report
    end

    def run()
        puts @report.display
    end
end
