module StreetWorkoutManager
  class App
    attr_reader :events, :menu

    MENU = [
      { title: 'Показать упражнение', action: 'show_event' },
      { title: 'Добавить упражнение', action: 'add_event' },
      { title: 'Редактировать упражнение', action: 'edit_event' },
      { title: 'Удалить упражнение', action: 'delete_event' },
      { title: 'Сохранить упражнения', action: 'save_events' },
      { title: 'Сохранить меню', action: 'save_menu' }
    ].freeze

    MENU_FILENAME_DUMP = 'menu_dump'.freeze
    EVENTS_FILENAME_DUMP = 'events_dump'.freeze

    def initialize
      @events = load_events || Collection.new
      @menu = load_menu || Collection.new(MENU)
    end

    def start
      loop do
        show_menu
        choice = user_choice
        action(choice)
      end
    end

    private

    def show_menu
      puts 'Выберите действие:'
      menu_list
    end

    def user_choice
      gets.chomp.to_i
    end

    def action(choice)
      option = menu.show choice - 1

      send(option[:action]) if option
    end

    def event_list
      events.each_with_index { |event, index| puts "\t#{index + 1}. #{event[:title]}" }
    end

    def menu_list
      menu.each_with_index { |option, index| puts "\t#{index + 1}. #{option[:title]}" }
    end

    def clear_with_sleep
      sleep 2
      system('clear')
    end

    def handle_empty_collection
      puts 'К сожалению ничего не найдено :('
      clear_with_sleep
    end

    def handle_not_found
      puts 'Упс! Элемент не найден :('
      clear_with_sleep
    end

    def add_event
      puts 'Введите название упражнения:'
      title = gets.chomp
      puts 'Введите дату когда делали это упражнение:'
      date = gets.chomp

      new_event = { title: title, date: date, created_at: Time.now }
      events.add new_event
      puts 'Упражнение добавлено в коллекцию!'
      clear_with_sleep
    end

    def show_event
      if events.size.zero?
        handle_empty_collection
        return
      end

      puts 'Выберите какое упражнение вы хотите посмотреть:'
      event_list

      choice = user_choice
      event = events.show choice - 1

      handle_not_found and return unless event

      puts "Date: #{event[:date]} | Title: #{event[:title]} | Created At: #{event[:created_at]}"
    end

    def edit_event
      if events.size.zero?
        handle_empty_collection
        return
      end

      puts 'Выберите какое упражнение вы хотите отредактировать:'
      event_list

      choice = user_choice
      event = events.show choice - 1
      handle_not_found unless event

      puts 'Введите новое название упражнения:'
      title = gets.chomp
      puts 'Введите новую дату когда делали это упражнение:'
      date = gets.chomp

      edited_event = { title: title, date: date, created_at: Time.now }
      events.update(choice - 1, edited_event)
      puts 'Упражнение успешно обновлено!'
      clear_with_sleep
    end

    def delete_event
      if events.size.zero?
        handle_empty_collection
        return
      end

      puts 'Выберите какое упражнение вы хотите  удалить:'
      event_list

      choice = user_choice
      event = events.show choice - 1
      handle_not_found unless event

      events.delete(choice - 1)
      puts 'Упражнение успешно удалено!'
      clear_with_sleep
    end

    def save_events
      events.save(EVENTS_FILENAME_DUMP)

      puts 'Упражнение успешно сохранены!'
      clear_with_sleep
    end

    def save_menu
      menu.save(MENU_FILENAME_DUMP)

      puts 'Меню успешно сохранено!'
      clear_with_sleep
    end

    def load_events
      return unless File.exist? EVENTS_FILENAME_DUMP

      Marshal.load(File.open(EVENTS_FILENAME_DUMP))
    end

    def load_menu
      return unless File.exist? MENU_FILENAME_DUMP

      Marshal.load(File.open(MENU_FILENAME_DUMP))
    end
  end
end
