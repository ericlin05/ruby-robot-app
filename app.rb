
require 'class/robot'
require 'class/tabletop'
require 'class/command/command_factory'
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

    opts.on("-r", "--report [Report Type]", "simple or fancy") do |v|
        options[:report_type] = v.to_sym
    end

    opts.on("-x", "--width  [Tabletop Width]", "Integer only, default value will be used if invalid") do |v|
        options[:table_width] = v.to_i
    end

    opts.on("-y", "--height [Tabletop Height]", "Integer only, default value will be used if invalid") do |v|
        options[:table_height] = v.to_i
    end
  
    # This displays the help screen, all programs are
    # assumed to have this option.
    opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit
    end
end.parse!

# initialise tabletop and robot
tabletop = TableTop.new(options[:table_width], options[:table_height])
robot = Robot.new("R2-D2")
report = ReportFactory.getReport(robot, tabletop, options[:report_type])

puts ""
puts "Hello, my name is #{robot.name}. Welcome to my virtual world in the command line."
puts "You can use the following commands to navigate me on a tabletop:"
puts ""
puts "1. PLACE X,Y,F - placing robot on the tabletop, i.e. PLACE 5,5,NORTH"
puts "2. PLACE       - no parameter version of the previous one and will default to '0,0,NORTH'"
puts "2. MOVE        - will move the toy robot one unit forward in the direction it is currently facing"
puts "3. LEFT        - will turn the robot left without changing the position of it"
puts "4. RIGHT       - will turn the robot right without changing the position of it"
puts "5. REPORT      - will announce the X,Y and F of the robot"
puts "6. CLEAR       - will clear the movement history of the robot, handy when running test with multiple test cases"
puts "7. QUIT        - will quit the program"
puts "8. EXIT        - same as QUIT"
puts ""
puts "The initial command must be the \"PLACE\" command, and all commands will be ignored until the \"PLACE\" command is issued."
puts ""
puts "All commands are case-insensitive."
puts ""
puts "Have fun!"
puts ""

c = gets
# when piping data from a text file, will get a NIL error 
# when it reaches the end of the file, just a safe checking.
#
# Also make sure that the command is always lower case
c.chomp!.downcase! unless c.nil?

until c == 'quit' || c == 'exit'
    begin
        CommandFactory.getCommand(c, robot, tabletop, report)
                      .run
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
        c.chomp!.downcase!
    end
end
