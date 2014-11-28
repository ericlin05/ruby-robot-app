
require 'class/robot'
require 'class/tabletop'
require 'class/command'

# initialise tabletop and robot
tabletop = TableTop.new(5,5)
robot = Robot.new("R2-D2")

c = gets
# when piping data from a text file, will get a NIL error 
# when it reaches the end of the file, just a safe checking.
#
# Also make sure that the command is always lower case
c.chomp.downcase! unless c.nil?

until c == 'quit' || c == 'exit'
    begin
        Command.new(c).run(robot, tabletop)
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
