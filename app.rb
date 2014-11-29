
require 'class/robot'
require 'class/tabletop'
require 'class/command'
require 'optparse'
require 'class/report/report_factory'

# Getting command line parameters
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby -I . app.rb [options]"

  opts.on("-r", "--report [Report Type]", "Report Type: simple or fancy") do |v|
    options[:report_type] = v.to_sym
  end
end.parse!

# initialise tabletop and robot
tabletop = TableTop.new(5,5)
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
