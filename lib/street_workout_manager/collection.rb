require 'forwardable'

module StreetWorkoutManager
  class Collection
    attr_reader :resource_name, :items
    attr_accessor :storage

    extend Forwardable
    include Enumerable

    def_delegators :@items, :size

    def initialize(resource_name, data = [], storage: JsonStorage.new)
      @resource_name = resource_name
      @items = data
      @storage = storage
    end

    def show(id)
      @items[id]
    end

    def update(id, data)
      @items[id] = data
    end

    def delete(id)
      @items.delete_at(id)
    end

    def add(item)
      @items << item
    end

    def save
      storage.save(resource_name, self)
    end

    def load
      storage.load(resource_name)
    end
  end
end
