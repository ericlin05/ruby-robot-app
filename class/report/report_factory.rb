
require 'class/report/simple_report'
require 'class/report/fancy_report'

# A factory class that is responsible for creating an instance of
# a report class that will display the robot's position information
# on the screen
#
# Currently supported classes are: SimpleReport and FancyReport
class ReportFactory
    DEFAULT_TYPE = :simple
    SUPPORTED_TYPES = {
        :simple => 1,
        :fancy  => 1
    }

    # robot    - The Robot class instance
    # tabletop - The TableTop instance
    # type     - Optional, either :simple or :fancy
    def self.getReport(robot, tabletop, type=:simple)
        type = DEFAULT_TYPE if SUPPORTED_TYPES[type].nil?

        case type
            when :fancy
                FancyReport.new(robot, tabletop)
            else
                SimpleReport.new(robot, tabletop)
        end
    end
end
