module StreetWorkoutManager
  class Menu
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def action
      data.each_with_index do |row, idx|
        puts "#{idx + 1}. #{row[:title]}"
      end

      choice = gets.chomp.to_i
      data[choice - 1][:action]
    end
  end
end