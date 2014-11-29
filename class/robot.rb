require 'class/tabletop'
require 'class/not_ready_error'

class Robot
    # the list of valid directions that the robot can face
    # make it a hash table so that it is easy for lookup
    VALID_DIRECTIONS = {
        :NORTH => 1,
        :SOUTH => 1,
        :EAST  => 1,
        :WEST  => 1
    }

    # make those attributes read only from outside world
    attr_reader :table_top, :direction, :x, :y, :placed, :path

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
        @direction = VALID_DIRECTIONS[direction].nil? ? :NORTH : direction

        valid_location = x >= 0 && x <= table_top.width && y >= 0 && y <= table_top.height

        @x = valid_location ? x : 0
        @y = valid_location ? y : 0

        # it is a place at this coordinate
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

    def left
        _ensure_placed

        case @direction
            when :NORTH
                @direction = :WEST
            when :SOUTH
                @direction = :EAST
            when :EAST
                @direction = :NORTH
            when :WEST
                @direction = :SOUTH
        end
    end

    def right
        _ensure_placed

        case @direction
            when :NORTH
                @direction = :EAST
            when :SOUTH
                @direction = :WEST
            when :EAST
                @direction = :SOUTH
            when :WEST
                @direction = :NORTH
        end
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

    # the private class name will start with "_" for convension
    private :_ensure_placed, :_path_key
end
