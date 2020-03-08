# trying to test out some sort of background process so that i can have live updating info:
# module Kernel
#   def every(seconds)
#     loop
#     puts "this is a test"
#     puts get_todays_games(get_today)
#     sleep seconds
#     # yield
#   end
# end

# == 2nd options
# def every( time )
#   Thread.new {
#       loop do 
#           sleep(time)
#           yield
#       end
#   }
# end

# class Numeric
#   def seconds
#       self
#   end
#   def minutes
#       self * 60
#   end
#   def hours
#       self * 60 * 60
#   end
# end

# These will hang around until the process exits
every( 5.seconds ) { puts "It's been 5 seconds." }
every( 2.minutes ) { puts "It's been 2 minutes." }

# Do some other processing so it stays alive
sleep(1000)
