require "spec_helper"

describe "Vehicle" do 
  let!(:vehicle) { Vehicle.new("medium", 4) } 
  describe "#new" do

    it "initializes with two arguments, wheel size and number" do 
      expect{Vehicle.new("large", 4)}.to_not raise_error
    end
  end

  describe "#wheel_size" do 
    it "has a wheel_size" do
      vehicle.wheel_size = "small"
      expect(vehicle.wheel_size).to eq("small")
    end
  end

  describe "#wheel_number" do 
    it "has a wheel_number" do 
      vehicle.wheel_number = 2      
      expect(vehicle.wheel_number).to eq(2)
    end
  end

  describe "#go" do
    it "returns 'vrrrrrrrooom!'" do 
      expect(vehicle.go).to eq("vrrrrrrrooom!")
    end 
  end

  describe "#fill_up_tank" do 
    it "returns 'filling up!'" do 
      expect(vehicle.fill_up_tank).to eq("filling up!")
    end
  end
end