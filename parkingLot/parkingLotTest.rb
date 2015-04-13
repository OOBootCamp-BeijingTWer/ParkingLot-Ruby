require_relative('../parkingLot/parking_lot')
require_relative('../parkingLot/parking_boy')
require_relative('../parkingLot/smart_boy')
require_relative('../parkingLot/car')

describe "parking lot" do

  it "should store a car and pick it" do
    car = Car.new
    parking_lot = ParkingLot.new "A"

    car_index = parking_lot.store(car)

    expect(parking_lot.pick(car_index)).to eq(car)
  end

  it "should store more than one car and pick them" do
    car = Car.new
    another_car = Car.new
    parking_lot = ParkingLot.new "A"

    car_index = parking_lot.store(car)
    car_index_of_another_car = parking_lot.store(another_car)

    expect(parking_lot.pick(car_index)).to eq(car)
    expect(parking_lot.pick(car_index_of_another_car)).to eq(another_car)

  end

  it "cannot store a car when parking lot is full" do
    parking_lot = ParkingLot.new "A",2

    parking_lot.store(Car.new)
    parking_lot.store(Car.new)
    expect(parking_lot.store(Car.new)).to eq(false)
  end

  it "should not get a car twice" do
    parking_lot = ParkingLot.new "A",2

    ticket =parking_lot.store(Car.new)
    parking_lot.pick(ticket)
    expect(parking_lot.pick(ticket)).to eq(nil)
  end

  it "should not get a car from empty parking lot" do
    parking_lot = ParkingLot.new "A",2

    expect(parking_lot.pick(2)).to eq(nil)
  end

  describe "there is a parking boy"  do
    it "should store and get a car" do
      parking_lot = ParkingLot.new "A"
      parking_boy = ParkingBoy.new [parking_lot]
      car = Car.new
      ticket = parking_boy.store(car)
      expect(parking_boy.pick(ticket)).to eq(car)
    end

    it "should get a car stored by parking boy from parking lot" do
      parking_lot = ParkingLot.new "A"
      parking_boy = ParkingBoy.new [parking_lot]
      car = Car.new
      ticket = parking_boy.store(car)
      expect(parking_lot.pick(ticket)).to eq(car)
    end

    it "should get a car stored in parking lot" do
      parking_lot = ParkingLot.new "A"
      parking_boy = ParkingBoy.new [parking_lot]
      car = Car.new
      ticket = parking_lot.store(car)
      expect(parking_boy.pick(ticket)).to eq(car)
    end

    it "should get a car stored by parking boy from one of the parking lots" do
      parking_lots = [ParkingLot.new("A"), ParkingLot.new("B")]
      parking_boy = ParkingBoy.new parking_lots
      car = Car.new

      ticket = parking_boy.store(car)
      #parking_lot = parking_lots.find{|park| park.name == ticket.parking_lot}
      pickedCar = nil?
      parking_lots.each { |parking_lot|
        pickedCar = parking_lot.pick(ticket)
        if pickedCar != nil
          break
        end
      }
      expect(pickedCar).to eq(car)
    end

    it "should get a car stored in one set of parking lots from parking boy" do
      parking_lots = [ParkingLot.new("A"), ParkingLot.new("B")]
      parking_boy = ParkingBoy.new parking_lots
      car = Car.new

      ticket = parking_lots.last().store(car)

      expect(parking_boy.pick(ticket)).to eq(car)
    end

    it "should not store a car when all parking lots are full" do
      parking_lots = [ParkingLot.new("A", 0), ParkingLot.new("B", 0)]
      parking_boy = ParkingBoy.new parking_lots
      car = Car.new

      ticket = parking_boy.store(car)

      expect(ticket).to eq(false)
    end

    it "should not get a car from empty parking lots" do
      parking_lots = [ParkingLot.new("A"), ParkingLot.new("B")]
      parking_boy = ParkingBoy.new parking_lots
      car = Car.new

      expect(parking_boy.pick(0)).to eq(nil)
    end

    it "should store a car into first not full parking lot" do
      parking_lot_not_full = ParkingLot.new("B", 1)
      parking_lots = [ParkingLot.new("A", 0), parking_lot_not_full]
      parking_boy = ParkingBoy.new parking_lots
      car = Car.new

      ticket = parking_boy.store(car)

      expect(parking_lot_not_full.pick(ticket)).to eq(car)

    end

  end

  describe "there is a smart parking boy" do
    it "should pick a car given store a car into parking lot "do
      parking_lot = ParkingLot.new("A")
      smart_boy = SmartBoy.new [parking_lot]
      car = Car.new

      ticket = parking_lot.store(car)

      expect(smart_boy.pick(ticket)).to eq(car)
    end

    it "should store a car then can pick from parking lot"do
      parking_lot = ParkingLot.new("A")
      smart_boy = SmartBoy.new [parking_lot]
      car = Car.new

      ticket = smart_boy.store(car)

      expect(parking_lot.pick(ticket)).to eq(car)
    end

    it "should store and pick a car given one parking lot"do
      smart_boy = SmartBoy.new [ParkingLot.new("A"), ParkingLot.new("B")]
      car = Car.new

      ticket = smart_boy.store(car)

      expect(smart_boy.pick(ticket)).to eq(car)
    end

    it "should store a car into parking lot B given parking lot B has more space"do
      parking_lot_A = ParkingLot.new("A", 1)
      parking_lot_B = ParkingLot.new("B", 2)
      smart_boy = SmartBoy.new [parking_lot_A, parking_lot_B]
      car = Car.new

      ticket = smart_boy.store(car)
      expect(parking_lot_B.pick(ticket)).to eq(car)
    end
  end


end
