require 'class/tabletop'
require 'class/not_ready_error'

# This class contains the main logic for a robot to be placed, move
# and turn left or right
#
# It also contains the logic to track the movement of the robot by
# storing the x and y coordinates on each movement into a hash map
class Robot
    DEFAULT_DIRECTION = :NORTH

    # the list of valid directions that the robot can face
    # make it a hash table so that it is easy for lookup
    VALID_DIRECTIONS = {
        :NORTH => 1,
        :SOUTH => 1,
        :EAST  => 1,
        :WEST  => 1
    }

    # simple hash table for turning left
    MAPPING_TURN_LEFT = {
        :NORTH => :WEST,
        :SOUTH => :EAST,
        :EAST  => :NORTH,
        :WEST  => :SOUTH
    }

    # simple hash table for turning right
    MAPPING_TURN_RIGHT = {
        :NORTH => :EAST,
        :SOUTH => :WEST,
        :EAST  => :SOUTH,
        :WEST  => :NORTH
    }

    # make those attributes read only from outside world
    attr_reader :table_top, :direction, :x, :y, :placed, :path, :name

    # it would be too boring if the robot does not have a name, 
    # let's give it a name when creating a robot
    def initialize(name)
        @name = name
        @path = {}
    end

    # When placing Robot, we need to know which table top we want to place on,
    # which direction it should be facing and the starting position on the table
    #
    # table_top - The TableTop object
    # direction - The direction the robot will be facing, possible values are :NORTH, :SOUTH, :WEST and :EAST
    # x         - The X coordinate of the initial position
    # y         - The Y coordinate of the initial position
    def place(table_top, direction=:NORTH, x=0, y=0)
        @table_top = table_top
        @direction = VALID_DIRECTIONS[direction].nil? ? DEFAULT_DIRECTION : direction

        valid_location = x >= 0 && x <= table_top.width && y >= 0 && y <= table_top.height

        @x = valid_location ? x : 0
        @y = valid_location ? y : 0

        # it is a PLACE at this coordinate
        @path[_path_key] = 'P'

        # mark that this robot has been placed
        @placed = true
    end

    # move robot one unit towards the direction that it is facing
    # if it is already at the boundary of table and facing outside
    # we will not do any move at all
    def move
        _ensure_placed

        case @direction
            when :NORTH
                if @y < @table_top.height - 1
                    @y += 1
                    @path[_path_key] = 'M'
                end
            when :SOUTH
                if @y > 0
                    @y -= 1
                    @path[_path_key] = 'M'
                end
            when :EAST
                if @x < @table_top.width - 1
                    @x += 1
                    @path[_path_key] = 'M'
                end
            when :WEST
                if @x > 0
                    @x -= 1
                    @path[_path_key] = 'M'
                end
        end
    end

    # Allow robot to turn left by using the mapping hash
    def left
        _ensure_placed

        @direction = MAPPING_TURN_LEFT[@direction]
    end

    # Allow robot to turn right by using the mapping hash
    def right
        _ensure_placed

        @direction = MAPPING_TURN_RIGHT[@direction]
    end

    # Clear the path history of the robot
    # This is used so that we can simply pass all test cases in one file
    # and have the path history specific to a particular test case
    # by clearing the history at the end of each test case
    def clear
        @path = {}
    end

    # I provide this public function purely for unit testing purpose
    # so that I can make sure the path is added to the @path variable
    #
    # x - The x position on the tabletop
    # y - The y position on the tabletop
    def get_path_value(x, y)
        @path[x.to_s << "_" << y.to_s]
    end

    # If the robot is not placed, it will not be able to do any actions
    # we will simply raise an error when this happens
    def _ensure_placed
        raise NotReadyError unless @placed
    end

    # The key used to store in @path, which consist of x and y values
    def _path_key
        @x.to_s << "_" << @y.to_s
    end

    # the private class name will start with "_" for convention
    private :_ensure_placed, :_path_key
end
