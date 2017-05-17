require_relative './spec_helper'

describe Artist do
  before(:each) do
    Artist.reset_all
  end

  # What's the difference between let! and let?
  # Why do we need it? Change it to the non ! version
  # and see what test suddenly fails.
  # http://betterspecs.org/#let
  let!(:artist){Artist.new}


  it "can be initialized" do
    expect(artist).to be_an_instance_of(Artist)
  end

  it "can have a name" do
    artist.name = "Adele"
    expect(artist.name).to eq("Adele")
  end

  it 'converts its name to a url friendly parameter' do
    artist.name = 'Miley Cyrus'
    expect(artist.to_param).to eq("miley-cyrus")
  end

  describe "Class methods" do
    it "keeps track of the artists that have been created" do
      expect(Artist.all).to include(artist)
    end

    it "can count how many artists have been created" do
      expect(Artist.count).to eq(1)
    end

    it "can find an artist by name" do
      artist.name = 'Miley Cyrus'
      expect(Artist.find_by_name('Miley Cyrus')).to eq(artist)
    end

    it "can reset the artists that have been created" do
      Artist.reset_all
      expect(Artist.count).to eq(0)
    end
  end

  describe "with songs" do
    let(:song){Song.new}

    it "can have a song added" do
      artist.add_song(song)
      expect(artist.songs).to include(song)
    end

    it "knows how many songs it has" do
      artist.add_songs([song, Song.new])
      expect(artist.songs.count).to eq(2)
    end
  end

end
