
# This class represents a tabletop that a robot will be exploring on
# I put it in a separate class so that any further logic that we need 
# to add in the the future, can be added here without affecting the
# robot class
#
# Possible extensions:
#   1. Add obstacles on the table 
#   2. Add holes on the table
class TableTop
    DEFAULT_WIDTH  = 5
    DEFAULT_HEIGHT = 5

    # define the attributes that can only be read
    attr_reader :width, :height

    # When TableTop is created, we need to know the size of the table
    def initialize(width, height)
        @width = width
        @height = height
    end
end
