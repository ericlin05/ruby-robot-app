require 'class/report/abstract_report'

# This class will give us a better visual on where the robot
# is currently at by displaying a grid on the screen
#
# Example:
# . . . . . 4
# . . . . . 3
# P M M . . 2
# . . M R . 1
# . . . . . 0
# 0 1 2 3 4
#
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
                    output << "R"
                elsif !@robot.path[w.to_s << "_" << h.to_s].nil?
                    output << @robot.path[w.to_s << "_" << h.to_s]
                else
                    output << "."
                end

                # add the number spaces after each coordinate based on the 
                # number of digits of the table width
                output << " " * @tabletop.width.to_s.length
            end

            # print out the Y values on the right
            # add the left padding so that it is easier to read
            output << h.to_s.rjust(@tabletop.height.to_s.length, '0') << "\n"
        end

        # prints out the X values at the bottom
        (0...@tabletop.width).each do |w|
            output << w.to_s.rjust(@tabletop.width.to_s.length, '0') << " "
        end
        output.strip!
        output << "\n\n"

        # Now display the information same as the SimpleReport
        output << @robot.x.to_s << "," << @robot.y.to_s << "," << @robot.direction.to_s << "\n\n"
    end
end
