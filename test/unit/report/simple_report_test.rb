
require 'test/unit'
require 'class/report/simple_report'
require 'class/robot'
require 'class/tabletop'

class SimpleReportTest < Test::Unit::TestCase
    def test_display
        tabletop = TableTop.new(5, 5)
        robot = Robot.new("Test")
        report = SimpleReport.new(robot, tabletop)

        robot.place(tabletop, :NORTH, 0, 4)
        assert_equal("0,4,NORTH", report.display, "Initial position should be at 0,4 and facing NORTH")

        robot.left
        assert_equal("0,4,WEST", report.display, "Turned left from NORTH, now should be facing WEST, and at the same location")

        # unable to move to west because we are on the edge
        # so nothing will happen
        robot.move
        assert_equal("0,4,WEST", report.display, "Should not be able to move, remain at the same location")

        robot.left
        assert_equal("0,4,SOUTH", report.display, "Turned left from WEST, now should be facing SOUTH")

        robot.move
        assert_equal("0,3,SOUTH", report.display, "Moved from 4 to 3 in SOUTH direction")

        robot.left
        assert_equal("0,3,EAST", report.display, "Turned left from SOUTH, now should be facing EAST")

        robot.move
        assert_equal("1,3,EAST", report.display, "Moved from [0,3] to [1,3], and still facing EAST")
    end

    def test_display_raises_error_if_robot_is_not_placed
        tabletop = TableTop.new(5, 10)
        robot = Robot.new("Test")
        report = SimpleReport.new(robot, tabletop)
        assert_raise(NotReadyError) { report.display }
    end
end
