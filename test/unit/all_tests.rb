
# relevant test::unit requires
require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'

# TestCase classes that contain the methods I want to execute
require 'test/unit/robot_test'
require 'test/unit/tabletop_test'
require 'test/unit/command/command_test'
require 'test/unit/report/fancy_report_test'
require 'test/unit/report/simple_report_test'

# create a new empty TestSuite, giving it a name
testsuite = Test::Unit::TestSuite.new("Robot Simulation Tests")

testsuite << RobotTest.suite
testsuite << TableTopTest.suite
testsuite << SimpleReportTest.suite
testsuite << FancyReportTest.suite
testsuite << CommandFactoryTest.suite

Test::Unit::UI::Console::TestRunner.run(testsuite)
