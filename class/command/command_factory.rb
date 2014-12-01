
require 'class/invalid_command_error'
require 'class/command/report_command'
require 'class/command/robot_general_command'
require 'class/command/robot_place_command'

# Only this class should be used to get the command object
class CommandFactory
    def self.getCommand(command, robot, tabletop, report)
        tmp = command.split(' ')

        if tmp.length < 1
            raise InvalidCommandError
        end

        case tmp[0].downcase
            when 'place'
                RobotPlaceCommand.new(command, robot, tabletop)
            when 'report'
                ReportCommand.new(command, report)
            else
                RobotGeneralCommand.new(command,robot)
        end
    end
end