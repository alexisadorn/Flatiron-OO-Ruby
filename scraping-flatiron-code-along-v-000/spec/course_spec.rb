require_relative "./spec_helper"
require_relative "../lib/course.rb"

describe "Course" do 

  let(:course) {Course.new}

  context "instance methods" do 
    describe "#title" do 
      it "has a setter and a getter method for title" do 
        course.title = "Programming Robots for Outer Space"
        expect(course.title).to eq("Programming Robots for Outer Space")
      end
    end

    describe "#schedule" do 
      it "has a setter and a getter method for a course's schedule" do 
        course.schedule = "Full-Time"
        expect(course.schedule).to eq("Full-Time")
      end
    end

    describe "#description" do 
      it "has a setter and a getter method for a course's description" do 
        course.description = "Learn how to program robots to explore the depths of space. Guest lecturer: The Mars Rover"
        expect(course.description).to eq("Learn how to program robots to explore the depths of space. Guest lecturer: The Mars Rover")
      end
    end
  end


  context "class methods" do 
    describe ".all" do 
      it "returns and array of all the instances of the Course class" do
        Course.reset_all
        course_one = Course.new
        course_two = Course.new
        course_three = Course.new 
        expect(Course.all).to match_array([course, course_one, course_two, course_three])
      end
    end
  end
end




