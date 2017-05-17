require 'spec_helper'
require 'pry'

describe "Song Class Methods" do
  describe '.create' do
    it 'instantiates and saves the song, and it returns the new song that was created' do
      song = Song.create
      expect(song).to be_a(Song)
      expect(Song.all).to include(song)
    end
  end

  describe '.new_by_name' do
    it 'instantiates a song with a name property' do
      song = Song.new_by_name("Blank Space")
      expect(song.name).to eq("Blank Space")
    end
  end

  describe '.create_by_name' do
    it 'instantiates and saves a song with a name property' do
      song = Song.create_by_name("Blank Space")

      expect(song.name).to eq("Blank Space")
      expect(Song.all).to include(song)
    end
  end

  describe '.find_by_name' do
    it 'can find a song present in @@all by name' do
      song_1 = Song.create_by_name("Blank Space")
      song_2 = Song.create_by_name("Hello")
      song_3 = Song.create_by_name("Hotline Bling")

      expect(Song.find_by_name("Hello")).to eq(song_2)
    end
  end

  describe '.find_or_create_by_name' do
    it 'creates a new song if one doesn\'t already exist' do
      song_1 = Song.find_or_create_by_name("Blank Space")
      expect(song_1.name).to eq("Blank Space")
    end

    it 'finds song by name if song has already been created' do
      song_1 = Song.find_or_create_by_name("Blank Space")
      song_2 = Song.find_or_create_by_name("Blank Space")
      expect(song_1).to be_a(Song)
      expect(song_2).to be_a(Song)
      expect(song_1.name).to eq(song_2.name)
    end
  end

  describe '.alphabetical' do
    it 'returns all the song instances in alphabetical order by song name' do
      song_1 = Song.create_by_name("Thriller")
      song_2 = Song.create_by_name("Blank Space")
      song_3 = Song.create_by_name("Call Me Maybe")

      expect(Song.alphabetical).to eq([song_2, song_3, song_1])
    end
  end

  describe '.new_from_filename' do
    it 'initializes a song and artist_name based on the filename format' do
      song = Song.new_from_filename("Thundercat - For Love I Come.mp3")
      expect(song.name).to eq("For Love I Come")
      expect(song.artist_name).to eq("Thundercat")
    end
  end

  describe '.create_from_filename' do
    it 'initializes and saves a song and artist_name based on the filename format' do
      song = Song.create_from_filename("Thundercat - For Love I Come.mp3")
      song_match = Song.find_by_name("For Love I Come")
      expect(song_match.name).to eq("For Love I Come")
      expect(song_match.artist_name).to eq("Thundercat")
    end
  end

  describe '.destroy_all' do
    it 'clears all the song instances from the @@all array' do
      Song.destroy_all
      expect(Song.all).to eq([])
    end
  end
end
