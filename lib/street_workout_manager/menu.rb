module StreetWorkoutManager
  class Menu
    def initialize(actions)
      @actions = actions
    end

    def action
      @actions.each_with_index do |action, index|
        puts "#{index + 1}. #{action[:title]}"
      end

      user_choice = gets.chomp.to_i

      @actions[user_choice - 1][:action]
    end
  end
end
