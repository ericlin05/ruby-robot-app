require 'test/unit'
require 'class/robot'
require 'class/not_ready_error'

class RobotTest < Test::Unit::TestCase
    def setup
        @robot = Robot.new("R2-D2")
    end

    def test_place_with_valid_direction
        Robot::VALID_DIRECTIONS.each_key do | dir |
            table_top = TableTop.new(5, 5)
            @robot.place(table_top, dir)
            assert_equal(dir, @robot.direction)
        end
    end

    def test_place_with_invalid_direction_default_to_north
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :TEST)

        assert_equal(:NORTH, @robot.direction)
    end

    def test_place_default_x_y_direction
        table_top = TableTop.new(5, 10)
        @robot.place(table_top)

        assert_equal(:NORTH, @robot.direction)
        assert_equal(0, @robot.x, "X position should be default to 0")
        assert_equal(0, @robot.y, "Y position should be default to 0")
    end

    def test_place_passed_x_y_direction
        table_top = TableTop.new(10, 20)
        @robot.place(table_top, :SOUTH, 3, 8)

        assert_equal(:SOUTH, @robot.direction)
        assert_equal(3, @robot.x, "X position should be equal to 3")
        assert_equal(8, @robot.y, "Y position should be equal to 8")
    end

    def test_place_passed_x_out_of_bound
        table_top = TableTop.new(10, 20)
        @robot.place(table_top, :EAST, 30, 8)

        assert_equal(:EAST, @robot.direction)
        assert_equal(0, @robot.x, "X position should be default to 0 because passed x value of 30 is out of boundary of the table")
        assert_equal(0, @robot.y, "Y position should be default to 0 because passed x value of 30 is out of boundary of the table")
    end

    def test_place_passed_y_out_of_bound
        table_top = TableTop.new(10, 20)
        @robot.place(table_top, :EAST, 3, 21)

        assert_equal(:EAST, @robot.direction)
        assert_equal(0, @robot.x, "X position should be default to 0 because passed y value of 21 is out of boundary of the table")
        assert_equal(0, @robot.y, "Y position should be default to 0 because passed y value of 21 is out of boundary of the table")
    end

    # Robot is place at position [0,0] and facing NORTH
    # the move command will move it to position [0,1] and still facing NORTH
    def test_can_move_north
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :TEST)

        assert_equal(:NORTH, @robot.direction)

        @robot.move
        assert_equal(0, @robot.x, "X position should be 0 (not changed)")
        assert_equal(1, @robot.y, "Y position should be 1 (moved 1 north)")
        assert_equal(:NORTH, @robot.direction, "Direction should be :NORTH (not changed)")
    end

    # Robot is place at position [1,5] and facing NORTH
    # the move command will do nothing as it is at the NORTH boundary
    def test_can_not_move_north
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :TEST, 1, 5)

        assert_equal(:NORTH, @robot.direction)

        @robot.move
        assert_equal(1, @robot.x, "X position should be 1 (not changed)")
        assert_equal(5, @robot.y, "Y position should be 5 (not changed)")
        assert_equal(:NORTH, @robot.direction, "Direction should be :NORTH (not changed)")
    end

    # Robot is place at position [1,2] and facing SOUTH
    # the move command will move it to position [1,1] and still facing SOUTH
    def test_can_move_south
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :SOUTH, 1, 2)

        assert_equal(:SOUTH, @robot.direction)

        @robot.move
        assert_equal(1, @robot.x, "X position should be 1 (not changed)")
        assert_equal(1, @robot.y, "Y position should be 1 (moved 1 south)")
        assert_equal(:SOUTH, @robot.direction, "Direction should be :SOUTH (not changed)")
    end

    # Robot is place at position [1,0] and facing SOUTH
    # the move command will do nothing as it is at the SOUTH boundary
    def test_can_not_move_south
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :SOUTH, 1, 0)

        assert_equal(:SOUTH, @robot.direction)

        @robot.move
        assert_equal(1, @robot.x, "X position should be 1 (not changed)")
        assert_equal(0, @robot.y, "Y position should be 0 (not changed)")
        assert_equal(:SOUTH, @robot.direction, "Direction should be :SOUTH (not changed)")
    end

    # Robot is place at position [1,2] and facing EAST
    # the move command will move it to position [2,2] and still facing EAST
    def test_can_move_east
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :EAST, 1, 2)

        assert_equal(:EAST, @robot.direction)

        @robot.move
        assert_equal(2, @robot.x, "X position should be 2 (moved 1 east)")
        assert_equal(2, @robot.y, "Y position should be 2 (not changed)")
        assert_equal(:EAST, @robot.direction, "Direction should be :EAST (not changed)")
    end

    # Robot is place at position [5,2] and facing EAST
    # the move command will do nothing as it is at the EAST boundary
    def test_can_not_move_east
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :EAST, 5, 2)

        assert_equal(:EAST, @robot.direction)

        @robot.move
        assert_equal(5, @robot.x, "X position should be 5 (not changed)")
        assert_equal(2, @robot.y, "Y position should be 2 (not changed)")
        assert_equal(:EAST, @robot.direction, "Direction should be :EAST (not changed)")
    end

    # Robot is place at position [5,5] and facing WEST
    # the move command will move it to position [4,5] and still facing WEST
    def test_can_move_west
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :WEST, 5, 5)

        assert_equal(:WEST, @robot.direction)

        @robot.move
        assert_equal(4, @robot.x, "X position should be 4 (moved 1 east)")
        assert_equal(5, @robot.y, "Y position should be 5 (not changed)")
        assert_equal(:WEST, @robot.direction, "Direction should be :WEST (not changed)")
    end

    # Robot is place at position [0,4] and facing WEST
    # the move command will do nothing as it is at the WEST boundary
    def test_can_not_move_west
        table_top = TableTop.new(5, 5)
        @robot.place(table_top, :WEST, 0, 4)

        assert_equal(:WEST, @robot.direction)

        @robot.move
        assert_equal(0, @robot.x, "X position should be 0 (not changed)")
        assert_equal(4, @robot.y, "Y position should be 4 (not changed)")
        assert_equal(:WEST, @robot.direction, "Direction should be :WEST (not changed)")
    end

    def test_left
        # the expected result aftering turning left
        expected = {
            :NORTH => :WEST,
            :SOUTH => :EAST,
            :EAST  => :NORTH,
            :WEST  => :SOUTH
        }
        table_top = TableTop.new(5, 5)

        expected.each do |current_facing, after_facing|
            @robot.place(table_top, current_facing, 0, 4)
            @robot.left
            assert_equal(after_facing, @robot.direction)
        end
    end

    def test_right
        # the expected result aftering turning right
        expected = {
            :NORTH => :EAST,
            :SOUTH => :WEST,
            :EAST  => :SOUTH,
            :WEST  => :NORTH
        }
        table_top = TableTop.new(5, 5)

        expected.each do |current_facing, after_facing|
            @robot.place(table_top, current_facing, 0, 4)
            @robot.right
            assert_equal(after_facing, @robot.direction)
        end
    end

    # this test that we should get the NotReadyError if we try to do
    # any actions before robot is placed
    def test_not_ready_error_before_place
        assert_raise(NotReadyError) { @robot.move }
        assert_raise(NotReadyError) { @robot.left }
        assert_raise(NotReadyError) { @robot.right }
    end
end
