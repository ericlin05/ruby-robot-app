
require 'class/robot'
require 'class/tabletop'
require 'class/command'
require 'optparse'
require 'class/report/abstract_report'
require 'class/report/report_factory'

# Getting command line parameters
# Setup default options
options = {
    :report_type  => AbstractReport::DEFAULT_TYPE,
    :table_width  => TableTop::DEFAULT_WIDTH,
    :table_height => TableTop::DEFAULT_HEIGHT
}

OptionParser.new do |opts|
    opts.banner = "Usage: ruby -I . app.rb [options]"

    opts.on("-r", "--report [Report Type]", "Report Type: simple or fancy") do |v|
        options[:report_type] = v.to_sym
    end

    opts.on("-w", "--width [Table Top Width]", "Table Top's width") do |v|
        options[:table_width] = v.to_i
    end

    opts.on("-h", "--height [Table Top Height]", "Table Top's Height") do |v|
        options[:table_height] = v.to_i
    end
end.parse!

# initialise tabletop and robot
tabletop = TableTop.new(options[:table_width], options[:table_height])
robot = Robot.new("R2-D2")
report = ReportFactory.getReport(robot, tabletop, options[:report_type])

c = gets
# when piping data from a text file, will get a NIL error 
# when it reaches the end of the file, just a safe checking.
#
# Also make sure that the command is always lower case
c.chomp.downcase! unless c.nil?

until c == 'quit' || c == 'exit'
    begin
        Command.new(c).run(robot, tabletop, report)
    rescue NotReadyError => e 
        puts e.message
    rescue InvalidCommandError => e
        puts e.message
    rescue InvalidParamsError => e
        puts e.message
    ensure
        # read input again
        c = gets
        break if c.nil?
        c.chomp.downcase!
    end
end
