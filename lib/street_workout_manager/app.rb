module StreetWorkoutManager
  class App
    ACTIONS = [
      { title: 'Список упражнений', action: :event_list },
      { title: 'Показать упражнение', submenu: { title: "Выберите упражнение", action: :event_list } },
      { title: 'Добавить упражнение', action: :add_event },
      { title: 'Редактировать упражнение', submenu: { title: "Выберите упражнение", action: :event_list } },
      { title: 'Удалить упражнение', submenu: { title: "Выберите упражнение", action: :event_list } },
      { title: 'Сохранить упражнения', action: :save_events }
    ].freeze

    attr_reader :data, :menu

    def initialize
      @data = Collection.new('workout')
      @data = @data.load || @data
      @menu = Menu.new(ACTIONS)
    end

    def start
      loop do
        send(menu.action)
      end
    end

    def event_list
      puts data
    end

    def show_event(idx)
      puts data.show(idx)
    end

    def add_event
      new_event = EventFactory.create
      data.add(new_event)
    end

    def edit_event(idx)
      updated_event = EventFactory.edit(data.show(idx))
      data.update(idx, updated_event)
    end

    def delete_event(idx)
      data.delete(idx)
    end

    def save_events
      data.save
    end
  end
end
