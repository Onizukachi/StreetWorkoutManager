module StreetWorkoutManager
  class FileStorage
    def save(filename, data)
      File.open(filename, 'wb') { |f| f.write(Marshal.dump(data)) }
    end

    def load(filename)
      Marshal.load(File.open(filename)) if File.exist?(filename)
    end
  end
end
