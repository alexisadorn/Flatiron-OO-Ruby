require "spec_helper"

describe "car" do 
  let!(:car) { Car.new("medium", 4) } 
  describe "#new" do

    it "initializes with two arguments, wheel size and number" do 
      expect{Car.new("large", 4)}.to_not raise_error
    end
  end

  describe "#wheel_size" do 
    it "has a wheel_size" do
      car.wheel_size = "small"
      expect(car.wheel_size).to eq("small")
    end
  end

  describe "#wheel_number" do 
    it "has a wheel_number" do 
      car.wheel_number = 2      
      expect(car.wheel_number).to eq(2)
    end
  end

  describe "#go" do
    it "returns 'VRRROOOOOOOOOOOOOOOOOOOOOOOM!!!!!'" do 
      expect(car.go).to eq("VRRROOOOOOOOOOOOOOOOOOOOOOOM!!!!!")
    end 
  end

  describe "#fill_up_tank" do 
    it "returns 'filling up!'" do 
      expect(car.fill_up_tank).to eq("filling up!")
    end
  end
end
