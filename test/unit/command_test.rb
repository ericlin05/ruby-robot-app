
require 'test/unit'
require 'class/command'

class CommandTest < Test::Unit::TestCase
    # test that both upper and lower cases are OK
    def testInitialiseValidCommand
        command = Command.new("PLACE 3,4,SOUTH")
        assert_equal("place", command.command)
        assert_equal([3,4,"SOUTH"], command.params)

        command = Command.new("plAce 3,4,east")
        assert_equal("place", command.command)
        assert_equal([3,4,"EAST"], command.params)

        command = Command.new("place")
        assert_equal("place", command.command)
        assert_equal([0,0,"NORTH"], command.params)

        command = Command.new("MOVE")
        assert_equal("move", command.command)

        command = Command.new("move")
        assert_equal("move", command.command)

        command = Command.new("LEFT")
        assert_equal("left", command.command)

        command = Command.new("left")
        assert_equal("left", command.command)

        command = Command.new("RIGHT")
        assert_equal("right", command.command)

        command = Command.new("right")
        assert_equal("right", command.command)

        command = Command.new("REPORT")
        assert_equal("report", command.command)

        command = Command.new("report")
        assert_equal("report", command.command)
    end

    def testInitialiseInValidCommand
        assert_raise(InvalidCommandError) { Command.new("Test") }
        assert_raise(InvalidCommandError) { Command.new("another test") }

        assert_raise(InvalidParamsError) { Command.new("place a,b,north") }
        assert_raise(InvalidParamsError) { Command.new("place 1,b,north") }
        assert_raise(InvalidParamsError) { Command.new("place a,3,north") }
        assert_raise(InvalidParamsError) { Command.new("place 1,3,test") }
    end
end
