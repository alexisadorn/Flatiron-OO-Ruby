require "spec_helper"

describe "Song" do

  describe "#new" do 
    it "initializes with a name and a genre" do 
      rap = Genre.new("rap")
      expect{Song.new("Lucifer", rap)}.to_not raise_error
    end
  end

  describe "#genre" do
    it "belongs to a genre" do 
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)

      expect(ninety_nine_problems.genre).to eq(rap)
    end 
  end

  describe "#artist" do
    it "belongs to a artist" do 
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)

      ninety_nine_problems.artist = jay_z
      expect(ninety_nine_problems.artist).to eq(jay_z)
    end 
  end
end