class ParkingBoy
  def initialize parking_lots
    @parkingLots = parking_lots
  end
  def store car
    @parkingLots.each{ |parking_lot|
      ticket = parking_lot.store(car)
      if ticket
        return ticket
      end
    }
    false
  end

  def pick ticket
    @parkingLots.each { |parking_lot|
      pickedCar = parking_lot.pick(ticket)
      if pickedCar != nil
        return pickedCar
      end
    }
    return nil
  end
end
