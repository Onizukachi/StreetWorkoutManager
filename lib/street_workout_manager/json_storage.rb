module StreetWorkoutManager
  class JsonStorage
    def save(filename, data)
      File.write("#{filename}.json", data.to_json)
    end

    def load(filename)
      return unless File.exist?("#{filename}.json")

      file = File.read("./#{filename}.json")
      JSON.parse(file)
    end
  end
end
