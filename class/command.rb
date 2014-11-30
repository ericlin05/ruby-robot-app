require 'class/invalid_command_error'
require 'class/invalid_params_error'
require 'class/robot'

# This class will parse the string passed into its initialiser
# and covert it into its known commands and parameters that can 
# be used by this simple app
class Command
    VALID_COMMANDS = {
        :PLACE  => 1,
        :MOVE   => 1,
        :LEFT   => 1,
        :RIGHT  => 1,
        :REPORT => 1,
        :CLEAR  => 1
    }

    # the valid number format for coordinates
    NUMBER_PATTERN = /[0-9]+/;

    # only allow read access to command and params
    attr_reader :command, :params

    def initialize(command)
        tmp = command.split(" ")

        # expecting a command and list of parameters (2 strings separated by space)
        # also need to make sure that the command (params[0]) must be valid
        if (tmp.length != 1 && tmp.length != 2) || VALID_COMMANDS[tmp[0].upcase.to_sym].nil?
            raise InvalidCommandError
        end

        @command = tmp[0].downcase
        @params = []

        if tmp.length == 2
            params = tmp[1].split(',')

            # 1. we are expecting 3 parameters
            # 2. first parameter must be an integer
            # 3. second parameter must be an integer
            # 4. third parameter must be a string and one of the following:
            #    NORTH, SOUTH, EAST, WEST
            if  params.length != 3 || 
                !params[0].match(NUMBER_PATTERN) || 
                !params[1].match(NUMBER_PATTERN) ||
                Robot::VALID_DIRECTIONS[params[2].upcase.to_sym].nil?
                raise InvalidParamsError
            end

            params[0] = params[0].to_i
            params[1] = params[1].to_i
            params[2].upcase!

            @params = params
        end

        if @command == 'place' && @params.length != 3
            @params = [ 0, 0, Robot::DEFAULT_DIRECTION.to_s ]
        end
    end

    def run(robot, tabletop, report)
        case @command
            when 'place'
                robot.send(@command, tabletop, @params[2].to_sym, @params[0], @params[1])
            when 'report'
                puts report.send("display")
            else
                robot.send(@command)
        end
    end
end
