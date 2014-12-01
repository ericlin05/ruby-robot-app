
require 'class/command/abstract_command.rb'

# The general commands required for Robot class
# It supports "move", "right" and "left", which do not
# need any further parameters
class RobotGeneralCommand < AbstractCommand
    def initialize(command, robot)
        super(command)

        @robot = robot
    end

    def run()
        @robot.send(@command)
    end
end
