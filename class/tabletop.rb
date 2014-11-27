
class TableTop
    # define the attributes that can only be read
    attr_reader :width, :height

    # When TableTop is created, we need to know the size of the table
    def initialize(width, height)
        @width = width
        @height = height
    end

    def is_at_left_edge
    end
end
