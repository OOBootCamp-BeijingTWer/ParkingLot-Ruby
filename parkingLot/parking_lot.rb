class ParkingLot
  attr_accessor :space
  def initialize name, capacity = 10
    @space = capacity
    @storage = Hash.new
    @capacity = capacity
  end

  def store car
    if @space < 1
      return false
    end
    index = @space
    @storage[index] = car
    @space = @capacity - @storage.length
    return index
  end

  def pick car_index
    @storage.delete(car_index)
  end
end