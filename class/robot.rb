require 'class/tabletop'
require 'class/robot_not_ready_error'

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
    attr_reader :table_top, :direction, :x, :y

    # it would be too boring if the robot does not have a name, 
    # let's give it a name when creating a robot
    def initialize(name)
        @name = name
    end

    # When placing Robot, we need to know which table top we want to place on,
    # which direction it should be facing and the starting position on the table
    def place(table_top, direction=:NORTH, x=0, y=0)
        @table_top = table_top
        @direction = VALID_DIRECTIONS[direction].nil? ? :NORTH : direction

        valid_location = x >= 0 && x <= table_top.width && y >= 0 && y <= table_top.height

        @x = valid_location ? x : 0
        @y = valid_location ? y : 0

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
            @y += 1 if @y < @table_top.height
        when :SOUTH
            @y -= 1 if @y > 0
        when :EAST
            @x += 1 if @x < @table_top.width
        when :WEST
            @x -= 1 if @x > 0
        end
    end

    def left

    end

    def right

    end

    def report

    end

    private
    def _ensure_placed
        raise NotPLacedError unless @placed
    end

end
