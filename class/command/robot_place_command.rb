
require 'class/command/abstract_command.rb'
require 'class/invalid_params_error'
require 'class/robot'

# This class supports the "place" command for Robot class
# It contains the logic to parse parameters required for "place" command
# and then triggers the robot.place() function
class RobotPlaceCommand < AbstractCommand
    # the valid number format for coordinates(x,Y)
    NUMBER_PATTERN = /[0-9]+/;

    attr_reader :x, :y, :direction

    def initialize(command, robot, tabletop)
        super(command)

        tmp = command.split(" ")

        # expecting a command and list of parameters (2 strings separated by space)
        # also need to make sure that the command (params[0]) must be valid
        if (tmp.length != 1 && tmp.length != 2) || VALID_COMMANDS[tmp[0].upcase.to_sym].nil?
            raise InvalidCommandError
        end

        # if the place command contains parameters, we need to parse
        # it and check for errors
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

            @x         = params[0].to_i
            @y         = params[1].to_i
            @direction = params[2].upcase.to_sym
        else
            # No params or too many params passed, use the default one
            @x         = 0
            @y         = 0
            @direction = Robot::DEFAULT_DIRECTION
        end

        @robot    = robot
        @tabletop = tabletop
    end

    def run()
        @robot.place(@tabletop, @direction, @x, @y)
    end
end
