
require 'test/unit'
require 'class/tabletop'

class TableTopTest < Test::Unit::TestCase
    def test_initialize_with_correct_width_height_set
        table_top = TableTop.new(5, 10)

        assert_equal(5, table_top.width, "Width should be equal to 5")
        assert_equal(10, table_top.height, "Height should be equal to 10")
    end

    def test_initialize_with_incorrect_width_height_value
        table_top = TableTop.new(0, 'a')

        assert_equal(5, table_top.width, "Width should be defaulted to 5")
        assert_equal(5, table_top.height, "Height should be defaulted to 5")
    end

    def test_initialize_with_less_than_default_value
        table_top = TableTop.new(2, 3)

        assert_equal(5, table_top.width, "Width should be defaulted to 5")
        assert_equal(5, table_top.height, "Height should be defaulted to 5")
    end
end
