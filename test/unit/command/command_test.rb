
require 'class/command/command_factory'
require 'class/robot'
require 'class/tabletop'
require 'class/report/simple_report'
require 'class/invalid_command_error'
require 'class/invalid_params_error'

require 'test/unit'
require 'mocha/test_unit'

class CommandFactoryTest < Test::Unit::TestCase
    def setup
        @robot = Robot.new("R2-D2")
        @tabletop = TableTop.new(10, 10)
        @report = SimpleReport.new(@robot, @tabletop)
    end

    def test_get_robot_move_command
        # mock the robot object to return string "moved"
        # when robot.move() is called
        @robot.stubs(:move).returns("moved")
        command = CommandFactory.getCommand('moVe', @robot, @tabletop, @report)

        assert_equal('move', command.command)
        assert_instance_of(RobotGeneralCommand, command)

        assert_equal("moved", command.run)
    end

    def test_get_robot_left_command
        # mock the robot object to return string "left"
        # when robot.left() is called
        @robot.stubs(:left).returns("left")

        command = CommandFactory.getCommand('LEFT', @robot, @tabletop, @report)

        assert_equal('left', command.command)
        assert_instance_of(RobotGeneralCommand, command)

        assert_equal("left", command.run)
    end

    def test_get_robot_right_command
        # mock the robot object to return string "right"
        # when robot.right() is called
        @robot.stubs(:right).returns("right")

        command = CommandFactory.getCommand('right', @robot, @tabletop, @report)

        assert_equal('right', command.command)
        assert_instance_of(RobotGeneralCommand, command)

        assert_equal("right", command.run)
    end

    def test_get_robot_place_command_default_params
        # mock the robot object to return string "placed"
        # when robot.place() is called
        @robot.stubs(:place).returns("placed")

        command = CommandFactory.getCommand('place', @robot, @tabletop, @report)

        assert_equal('place', command.command)
        assert_equal(:NORTH, command.direction)
        assert_equal(0, command.x)
        assert_equal(0, command.y)

        assert_instance_of(RobotPlaceCommand, command)
        assert_equal("placed", command.run)
    end

    def test_get_robot_place_command_passed_params
        # mock the robot object to return string "placed"
        # when robot.place() is called
        @robot.stubs(:place).returns("placed")

        command = CommandFactory.getCommand('place 4,5,EAST', @robot, @tabletop, @report)

        assert_equal('place', command.command)
        assert_equal(:EAST, command.direction)
        assert_equal(4, command.x)
        assert_equal(5, command.y)

        assert_instance_of(RobotPlaceCommand, command)
        assert_equal("placed", command.run)
    end

    def test_get_report_command
        # mock the report object to return string "displayed"
        # when report.display() is called
        @report.stubs(:display).returns("displayed")

        command = CommandFactory.getCommand('report', @robot, @tabletop, @report)

        assert_equal('report', command.command)
        assert_instance_of(ReportCommand, command)
    end

    def test_get_command_raises_error_when_no_command_is_passed
        assert_raise(InvalidCommandError) { CommandFactory.getCommand('invalid', @robot, @tabletop, @report) }
        assert_raise(InvalidCommandError) { CommandFactory.getCommand('testcommand', @robot, @tabletop, @report) }

        assert_raise(InvalidParamsError) { CommandFactory.getCommand('place a,b,north', @robot, @tabletop, @report) }
        assert_raise(InvalidParamsError) { CommandFactory.getCommand('place 1,b,north', @robot, @tabletop, @report) }
        assert_raise(InvalidParamsError) { CommandFactory.getCommand('place a,3,north', @robot, @tabletop, @report) }
        assert_raise(InvalidParamsError) { CommandFactory.getCommand('place 1,3,test', @robot, @tabletop, @report) }
    end
end