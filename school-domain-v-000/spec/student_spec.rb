require 'spec_helper'

describe 'School' do
  before :each do
    @school = School.new("Test School")
  end

  describe "::new" do
    it 'has an empty roster when initialized' do
      expect(@school.roster.length).to eq(0)
    end
  end

  describe "#add_student" do
    it 'is able to add a student' do
      @school.add_student("AC Slater", 10)
      expect(@school.roster).to eq({10 => ["AC Slater"]})
    end

    it 'is able to add multiple students to a class (grade)' do
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 10)

      expect(@school.roster).to eq({10 => ["Jeff Baird", "Blake Johnson"]})
    end

    it 'is able to add students to different grades' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Blake Johnson", 7)

      expect(@school.roster).to eq({9 => ["Homer Simpson"], 10 => ["Jeff Baird", "Avi Flombaum"], 7 => ["Blake Johnson"]})
    end
  end

  describe '#grade' do
    it 'is able to retreive students from a grade' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)

      expect(@school.grade(10)).to eq(["Avi Flombaum", "Jeff Baird"])
    end
  end

  describe "#sort" do
    it 'is able to sort the students' do
      @school.add_student("Homer Simpson", 9)
      @school.add_student("Bart Simpson", 9)
      @school.add_student("Avi Flombaum", 10)
      @school.add_student("Jeff Baird", 10)
      @school.add_student("Blake Johnson", 7)
      @school.add_student("Jack Bauer", 7)

      # key order does not matter; this is testing that the students in each respective value are in alphabetical order
      expect(@school.sort).to eq({7 => ["Blake Johnson", "Jack Bauer"], 9 => ["Bart Simpson", "Homer Simpson"], 10 => ["Avi Flombaum", "Jeff Baird"]})
    end
  end
end
