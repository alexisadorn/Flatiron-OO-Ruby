require "spec_helper"
require 'pry'

describe "Artist" do

  describe "#new" do 
    it "initializes with a name and an empty collection of songs" do
      taylor_swift = Artist.new("Taylor Swift")
      expect{Artist.new("Beyonce")}.to_not raise_error
      expect(taylor_swift.instance_variable_get(:@songs)).to eq([])
    end
  end

  describe "#name" do 
    it "has a name" do 
      jay_z = Artist.new("Jay-Z")
      
      expect(jay_z.name).to eq("Jay-Z")
    end
  end

  describe "#add_song" do 
    it "adds a new song to the artist's @songs array and tells that song that it belongs to the artist" do 
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)
      jay_z.add_song(ninety_nine_problems)
      
      expect(jay_z.instance_variable_get(:@songs)).to include(ninety_nine_problems)
      expect(ninety_nine_problems.artist).to eq(jay_z)
    end
  end

  describe "#songs" do 
    it "has many songs" do
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)
      jay_z.add_song(ninety_nine_problems) 
      
      expect(jay_z.songs).to include(ninety_nine_problems)
    end
  end

  describe "#genres" do 
    it "has many genres, through songs" do 
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)
      jay_z.add_song(ninety_nine_problems)
      
      expect(jay_z.genres).to include(rap)
      expect(jay_z.songs.first.genre).to eq(rap)
    end
  end
end