module StreetWorkoutManager
  class App
    DATA_FILENAME = 'data_dump'.freeze

    ACTIONS = [
      { title: 'Список упражнений', action: :event_list },
      { title: 'Показать упражнение', action: :show_event },
      { title: 'Добавить упражнение', action: :add_event },
      { title: 'Редактировать упражнение', action: :edit_event },
      { title: 'Удалить упражнение', action: :delete_event },
      { title: 'Сохранить упражнения', action: :save_events }
    ].freeze

    attr_reader :data, :menu

    def initialize
      @data = Collection.load(DATA_FILENAME) || Collection.new
      @menu = Menu.new(ACTIONS)
    end

    def start
      loop do
        send(menu.action)
      end
    end

    def event_list
      data
    end

    def show_event(idx)
      data.show(idx)
    end

    def add_event(event)
      data.add(event)
    end

    def edit_event(idx)
      data.show(idx)
    end

    def delete_event(idx)
      data.delete(idx)
    end

    def save_events
      data.save(DATA_FILENAME)
    end
  end
end
