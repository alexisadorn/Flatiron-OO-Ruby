require "spec_helper"

describe "Teacher" do 
  let!(:knowledge) { ["a String is a type of data in Ruby", "programming is hard, but it's worth it", "javascript async web request", "Ruby method call definition", "object oriented dog cat class instance", "class method class variable instance method instance variable", "programming computers hacking learning terminal", "bash Ruby rvm update certs"] }
  let!(:teacher) { Teacher.new }

  it "inherits from the User class" do
    expect(Teacher.ancestors).to include(User) 
  end
  
  describe "#first_name" do 
    it "has a first name" do 
      teacher.first_name = "Avi"
      expect(teacher.first_name).to eq("Avi")
    end
  end

  describe "#last_name" do 
    it "has a last name" do 
      teacher.last_name = "Flombaum"
      expect(teacher.last_name).to eq("Flombaum")
    end
  end

  describe "#teach" do 
    it "returns a random string of knowledge" do 
      expect(knowledge).to include(teacher.teach) 
    end
  end
end
