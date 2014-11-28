# According to good practice, it is a bad idea to extend from the Exception class in Ruby
# it is better to exend from StandardError instead
#
# This is because exceptions that inherit from StandardError deal with application 
# level errors, while if you inherit Exception directly you risk catching errors to do 
# with the environment. Also the convention is to end your exceptions with the word 
# Error rather than Exceptions
class NotReadyError < StandardError
    def message
        "Robot is not able to do any movement or direction change if it is not placed on a table top yet!"
    end
end
