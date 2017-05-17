require "spec_helper"

describe "Student" do 
  let!(:student) { Student.new }

  it "inherits from the User class" do
    expect(Student.ancestors).to include(User) 
  end
  
  describe "#first_name" do 
    it "has a first name" do 
      student.first_name = "Steve"
      expect(student.first_name).to eq("Steve")
    end
  end

  describe "#last_name" do 
    it "has a last name" do 
      student.last_name = "Jobs"
      expect(student.last_name).to eq("Jobs")
    end
  end

  describe "#new" do
    it "initializes with an empty knowledge array" do
      sophie = Student.new
      expect(sophie.instance_variable_get(:@knowledge)).to eq([]) 
    end 
  end

  describe "#learn" do 
    it "takes in an argument of a string of knowledge and adds it to the student's knowledge array" do 
      student.learn("Ruby framework Rails gem bundle update")
      expect(student.instance_variable_get(:@knowledge)).to include("Ruby framework Rails gem bundle update")
    end
  end

  describe "#knowledge" do 
    it "returns that student's knowledge array" do 
      student.learn("Javascript Ember Elixir knowledge") 
      expect(student.knowledge).to include("Javascript Ember Elixir knowledge")
    end
  end
end
