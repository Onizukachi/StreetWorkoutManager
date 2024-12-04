module StreetWorkoutManager
  class EventFactory
    class << self
      def create
        puts "Введите название упражнения:"
        title = gets.chomp

        puts "Введите дату:"
        date = gets.chomp

        puts "Введите количество повторений:"
        count = gets.chomp.to_i

        OpenStruct.new(title: title, date: date, count: count)
      end

      def edit(event)
        puts "Введите новое название упражнения: (было -> #{event.title}"
        title = gets.chomp
        event.title = title

        puts "Введите новую дату: (было -> #{event.date}"
        date = gets.chomp
        event.date = date

        puts "Введите новое количество повторений: (было -> #{event.count}"
        count = gets.chomp.to_i
        event.count = count

        event
      end
    end
  end
end
