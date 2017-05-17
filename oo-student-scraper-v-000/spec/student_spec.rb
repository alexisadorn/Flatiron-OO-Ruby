require "spec_helper"

describe "Student" do 
  let!(:student_index_array) {[{:name=>"Alex Patriquin", :location=>"New York, NY"},
 {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
 {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
 {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
 {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]}

 let!(:student_hash) {{:twitter=>"someone@twitter.com",
 :linkedin=>"someone@linkedin.com",
 :github=>"someone@github.com",
 :blog=>"someone@blog.com",
 :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 :bio=>
  "I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school."}}


  let!(:student) {Student.new({:name=>"Alex Patriquin", :location=>"New York, NY"})}
  
  after(:each) do 
    Student.class_variable_set(:@@all, [])
  end
  describe "#new" do
    it "takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash." do 
      expect{Student.new({:name => "Sophie DeBenedetto", :location => "Brooklyn, NY"})}.to_not raise_error
      expect(student.name).to eq("Alex Patriquin")
      expect(student.location).to eq("New York, NY")
    end 

    it "adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable." do 
      expect(Student.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    end
  end

  describe ".create_from_collection" do 
    it "uses the Scraper class to create new students with the correct name and location." do 
      Student.class_variable_set(:@@all, [])
      Student.create_from_collection(student_index_array)
      expect(Student.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    end
  end

  describe "#add_student_attributes" do 
    it "uses the Scraper class to get a hash of a given students attributes and uses that hash to set additional attributes for that student." do 
      student.add_student_attributes(student_hash) 
      expect(student.bio).to eq("I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school.")
      expect(student.blog).to eq("someone@blog.com")
      expect(student.linkedin).to eq("someone@linkedin.com")
      expect(student.profile_quote).to eq("\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi")
      expect(student.twitter).to eq("someone@twitter.com")
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
      Student.class_variable_set(:@@all, [])
      expect(Student.all).to match_array([])
    end
  end
end
