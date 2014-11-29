require 'class/report/abstract_report'

class FancyReport < AbstractReport
    def display
        "fancy report: #{@robot.x},#{@robot.y},#{@robot.direction}"
    end
end
