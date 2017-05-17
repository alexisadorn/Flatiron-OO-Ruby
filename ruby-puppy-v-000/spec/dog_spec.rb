require "spec_helper"

describe "Dog" do 

  let!(:pluto) { Dog.new("Pluto") }
  let!(:fido) { Dog.new("Fido") }
  let!(:maddy) { Dog.new("Maddy") }
  
  after(:each) do 
    Dog.class_variable_set(:@@all, [])
  end
  
  describe "Dog class variables" do 
    it "has a class variable, @@all, the points to an array" do 
      expect(Dog.class_variable_get(:@@all)).to be_a(Array)
    end
  end

  describe "#clear_all" do 
    it "is a class method that empties the @@all array of all existing dogs" do 
      Dog.clear_all
      expect(Dog.class_variable_get(:@@all)).to match([]  )
    end
  end

  describe "#all" do
    it "is a class method that puts out the name of each dog to the terminal" do 
      expect{Dog.all}.to output("Pluto\nFido\nMaddy\n").to_stdout
    end 
  
  describe "#new" do 
    it "initializes with an argument of a name" do 
      expect{Dog.new("Snoopy")}.to_not raise_error
    end

    it "adds the new dog to the @@all array" do
      expect(Dog.class_variable_get(:@@all)).to match([pluto, fido, maddy]) 
    end
  end

  end
    
  describe "#name" do 
    it "has a name" do 
      expect(pluto.name).to eq("Pluto")
    end
  end
end