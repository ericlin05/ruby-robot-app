
require 'class/report/abstract_report'

# This class simply display the position information in the simplest format
# As suggested by the requirement of this test
class SimpleReport < AbstractReport
    def display
        raise NotReadyError unless @robot.placed

        "#{@robot.x},#{@robot.y},#{@robot.direction}"
    end
end
