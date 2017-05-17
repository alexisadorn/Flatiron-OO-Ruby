require "spec_helper"

describe "Song" do 

  let!(:song) {Song.new("Survivor")}
  describe "#new" do 
    it "is initialized with an argument of a name" do 
      expect{Song.new("Say my Name")}.to_not raise_error
    end
  end

  describe "#name" do 
    it "has a name" do
      expect(song.name).to eq("Survivor")
    end
  end

  describe "#artist" do
    it "belongs to an artist" do 
      drake = Artist.new("Drake")
      song.artist = drake
      expect(song.artist).to eq(drake)
    end 
  end

  describe "#artist_name" do
    it "knows the name of its artist" do 
      drake = Artist.new("Drake")
      song.artist = drake
      expect(song.artist_name).to eq("Drake")
    end 

    it "returns nil if the song does not have an artist" do 
      song = Song.new("Cool for the Summer")
      expect(song.artist_name).to eq nil
    end
  end
end
