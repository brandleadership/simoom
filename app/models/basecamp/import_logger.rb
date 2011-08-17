module Basecamp
  class ImportLogger

    #
    # Only differentiate between debug and info
    #
    LOG_LEVELS = [:debug, :info]

    def initialize(log_level)
      raise 'Invalid Log Level' unless LOG_LEVELS.include? log_level
      @log_level = log_level
    end

    def log(message, message_log_level)
      raise 'Invalid Log Level' unless LOG_LEVELS.include? message_log_level

      # Print everything in debug mode and only info messages in info mode
      puts message if @log_level == :debug || message_log_level == :info
    end

  end
end
