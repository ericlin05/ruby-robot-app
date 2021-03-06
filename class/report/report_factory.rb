
require 'class/report/simple_report'
require 'class/report/fancy_report'

# A factory class that is responsible for creating an instance of
# a report class that will display the robot's position information
# on the screen
#
# Currently supported classes are: SimpleReport and FancyReport
class ReportFactory
    # robot    - The Robot class instance
    # tabletop - The TableTop instance
    # type     - Optional, either AbstractReport::REPORT_TYPE_SIMPLE or AbstractReport::REPORT_TYPE_FANCY
    def self.getReport(robot, tabletop, type=AbstractReport::DEFAULT_TYPE)
        type = AbstractReport::DEFAULT_TYPE if AbstractReport::SUPPORTED_TYPES[type].nil?

        case type
            when AbstractReport::REPORT_TYPE_FANCY
                FancyReport.new(robot, tabletop)
            else
                SimpleReport.new(robot, tabletop)
        end
    end
end
