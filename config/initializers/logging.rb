# # config/initializers/logging.rb
# Rails.logger.formatter = proc do |severity, datetime, progname, msg|
#   color = case severity
#           when "DEBUG" then :light_blue
#           when "INFO" then :light_green
#           when "WARN" then :yellow
#           when "ERROR" then :red
#           else :white
#           end
#   "\e[#{color.to_s}m#{datetime}: #{severity} -- #{msg}\e[0m\n"
# end