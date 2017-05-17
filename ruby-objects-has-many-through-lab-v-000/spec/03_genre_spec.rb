require "spec_helper"
require 'pry'

describe "Genre" do 

  describe "#new" do 
    it "initializes with a name and an empty collection of songs" do
      country = Genre.new("country")
      expect{Genre.new("pop")}.to_not raise_error
      expect(country.instance_variable_get(:@songs)).to eq([])
    end
  end

  describe "#name" do 
    it "has a name" do 
      rap = Genre.new("rap")
      expect(rap.name).to eq("rap")
    end
  end

  describe "#songs" do 
    it "has many songs" do
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)
       
      expect(rap.songs).to include(ninety_nine_problems)
    end
  end

  describe "#artists" do 
    it "has many artists, through songs" do 
      jay_z = Artist.new("Jay-Z")
      rap = Genre.new("rap")
      ninety_nine_problems = Song.new("99 Problems", rap)
      
      jay_z.add_song(ninety_nine_problems)
      expect(rap.artists).to include(jay_z)
      expect(rap.songs.first.artist).to eq(jay_z)
    end
  end
end