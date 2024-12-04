module StreetWorkoutManager
  class Configuration
    attr_accessor :storage

    def initialize
      @storage = JsonStorage.new
    end
  end

  class << self
    def config
      @config ||= Configuration.new
    end

    def configure
      yield config
    end
  end
end
