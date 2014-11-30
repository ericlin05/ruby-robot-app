
# A report super class that will help us to display robot's position on the tabletop
# The implementation of the display function should be implemented in the actual 
# class that knows how it wants to display the information
class AbstractReport
    REPORT_TYPE_SIMPLE = :simple
    REPORT_TYPE_FANCY  = :fancy

    DEFAULT_TYPE = REPORT_TYPE_SIMPLE
    SUPPORTED_TYPES = {
        REPORT_TYPE_SIMPLE => 1,
        REPORT_TYPE_FANCY  => 1
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
