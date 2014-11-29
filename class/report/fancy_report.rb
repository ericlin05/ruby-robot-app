require 'class/report/abstract_report'

# This class will give us a better visual on where the robot
# is currently at by displaying a grid on the screen
#
# Example:
# . . . . .
# . . . . .
# P M M . .
# . . M R .
# . . . . .
# 3,1,EAST
#
# P for Place
# M for Move
# R for Robot's current location
# and the last line shows its location and the direction it is facing
class FancyReport < AbstractReport
    def display
        raise NotReadyError unless @robot.placed

        output = ""

        (0...@tabletop.height).reverse_each do |h|
            (0...@tabletop.width).each do |w|
                if w == @robot.x && h == @robot.y
                    output << "R "
                elsif !@robot.path[w.to_s << "_" << h.to_s].nil?
                    output << @robot.path[w.to_s << "_" << h.to_s] << " "
                else
                    output << ". "
                end
            end
            output.strip!
            output << "\n"
        end

        # Now display the information same as the SimpleReport
        output << @robot.x.to_s << "," << @robot.y.to_s << "," << @robot.direction.to_s << "\n\n"
    end
end
