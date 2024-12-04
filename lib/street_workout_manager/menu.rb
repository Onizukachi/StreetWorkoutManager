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

      chosen_action = data[choice - 1]

      if chosen_action[:submenu]
        puts chosen_action[:submenu][:title]
        chosen_action[:action]
        choice = gets.chomp.to_i

      end
    end
  end
end