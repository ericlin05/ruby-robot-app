
require 'test/unit'
require 'class/report/fancy_report'
require 'class/robot'
require 'class/tabletop'

class FancyReportTest < Test::Unit::TestCase
    def test_display_case1
        tabletop = TableTop.new(5, 5)
        robot = Robot.new("Test")
        report = FancyReport.new(robot, tabletop)

        robot.place(tabletop, :NORTH, 1, 2)

        expected = <<EOF
. . . . . 4
. . . . . 3
. R . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

1,2,NORTH

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. . . . . 4
. R . . . 3
. P . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

1,3,NORTH

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. R . . . 4
. M . . . 3
. P . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

1,4,NORTH

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. R . . . 4
. M . . . 3
. P . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

1,4,NORTH

EOF
        assert_equal(expected, report.display)

        robot.right
        expected = <<EOF
. R . . . 4
. M . . . 3
. P . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

1,4,EAST

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. M R . . 4
. M . . . 3
. P . . . 2
. . . . . 1
. . . . . 0
0 1 2 3 4

2,4,EAST

EOF
        assert_equal(expected, report.display)
    end

    def test_display_case2
        tabletop = TableTop.new(5, 5)
        robot = Robot.new("Test")
        report = FancyReport.new(robot, tabletop)

        robot.place(tabletop, :NORTH, 0, 0)

        expected = <<EOF
. . . . . 4
. . . . . 3
. . . . . 2
. . . . . 1
R . . . . 0
0 1 2 3 4

0,0,NORTH

EOF
        assert_equal(expected, report.display)

        robot.left
        expected = <<EOF
. . . . . 4
. . . . . 3
. . . . . 2
. . . . . 1
R . . . . 0
0 1 2 3 4

0,0,WEST

EOF
        assert_equal(expected, report.display)

        # now place it again
        robot.place(tabletop, :SOUTH, 1, 2)
        expected = <<EOF
. . . . . 4
. . . . . 3
. R . . . 2
. . . . . 1
P . . . . 0
0 1 2 3 4

1,2,SOUTH

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. . . . . 4
. . . . . 3
. P . . . 2
. R . . . 1
P . . . . 0
0 1 2 3 4

1,1,SOUTH

EOF
        assert_equal(expected, report.display)

        robot.move
        expected = <<EOF
. . . . . 4
. . . . . 3
. P . . . 2
. M . . . 1
P R . . . 0
0 1 2 3 4

1,0,SOUTH

EOF
        assert_equal(expected, report.display)

        # clear the path history for this robot
        robot.clear
        expected = <<EOF
. . . . . 4
. . . . . 3
. . . . . 2
. . . . . 1
. R . . . 0
0 1 2 3 4

1,0,SOUTH

EOF
        assert_equal(expected, report.display)
    end

    def test_display_raises_error_if_robot_is_not_placed
        tabletop = TableTop.new(5, 10)
        robot = Robot.new("Test")
        report = FancyReport.new(robot, tabletop)
        assert_raise(NotReadyError) { report.display }
    end
end
