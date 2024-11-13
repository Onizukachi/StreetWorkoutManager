require 'forwardable'

module StreetWorkoutManager
  class Collection
    class NotFoundError < StandardError; end

    extend Forwardable
    include Enumerable

    def_delegators :@items, :size

    def initialize(data = [])
      @items = data
    end

    def each(&block)
      @items.each(&block)
    end

    def show(id)
      @items[id]
    end

    def update(id, attrs)
      @items[id] = attrs
    end

    def delete(id)
      @items.delete_at(id)
    end

    def add(item)
      @items << item
    end

    def save(path)
      File.open(path, 'wb') { |f| f.write(Marshal.dump(self)) }
    end
  end
end
