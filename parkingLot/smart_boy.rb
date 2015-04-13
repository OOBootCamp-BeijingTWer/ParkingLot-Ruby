
class SmartBoy < ParkingBoy
  def store car
    parking_lot = nil
    space = 0

    @parkingLots.each {|item|
      if item.space > space
        parking_lot = item
        space = item.space
      end
    }
    parking_lot.store(car)
  end

end