
# A report super class that will help us to display robot's position on the tabletop
# The implementation of the display function should be implemented in the actual 
# class that knows how it wants to display the information
class AbstractReport
    DEFAULT_TYPE = :simple
    SUPPORTED_TYPES = {
        :simple => 1,
        :fancy  => 1
    }

    def initialize(robot, tabletop)
        @robot = robot
        @tabletop = tabletop
    end

    # This function should be implemented by sub-classes
    def display
        raise StandardError "display function need to implemented by child classes"
    end
end
