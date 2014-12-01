
require 'class/invalid_command_error'

# This is an abstract command class that should be the base class
# for all commands that we want to support in this little app
#
# It contains a "run" function which must be implemented by children classes
class AbstractCommand
    VALID_COMMANDS = {
        :PLACE  => 1,
        :MOVE   => 1,
        :LEFT   => 1,
        :RIGHT  => 1,
        :REPORT => 1,
        :CLEAR  => 1
    }

    # only allow read access to command
    attr_reader :command

    def initialize(command)
        c = command.split(' ')

        # expecting a command
        if c.length < 1 || VALID_COMMANDS[c[0].upcase.to_sym].nil?
            raise InvalidCommandError
        end

        @command = c[0].downcase
    end

    # The function need to be overridden by children classes
    def run()
        raise StandardError "display function need to implemented by child classes"
    end
end
