require "spec_helper"

describe "Song" do
  let!(:song) { Song.new } 
  it "has a title" do
    song.title = "7/11" 
    expect(song.title).to eq("7/11")
  end

  it "belongs to an artist" do 
    artist = Artist.new
    song.artist = artist
    expect(song.artist).to eq(artist)
  end

  it "knows the name of the artist it belongs to" do 
    artist = Artist.new
    artist.name = "Beyonce"
    song.artist = artist
    expect(song.artist.name).to eq("Beyonce")
  end
end