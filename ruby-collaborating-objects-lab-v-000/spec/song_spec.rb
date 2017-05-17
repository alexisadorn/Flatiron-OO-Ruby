require 'pry'

describe 'Song' do
  let(:song) {Song.new('Man in the Mirror')}
  let(:file_name) {'Michael Jackson - Black or White - pop.mp3'}

  describe '#initialize with #name' do
    it 'accepts a name for the song' do
      expect(song.name).to eq('Man in the Mirror')
    end
  end

  describe '#name=' do
    it 'sets the song name' do
      song.name = 'Thriller'
      expect(song.name).to eq('Thriller')
    end
  end

  describe '#artist=' do
    it 'sets the artist object to belong to the song' do
      new_artist_object = Artist.new('King of Pop')
      song.artist = new_artist_object
      expect(song.artist).to eq(new_artist_object)
    end
  end

  describe '.new_by_filename' do
    it 'creates a new instance of a song from the file that\'s passed in' do
      #binding.pry
      new_instance = Song.new_by_filename(file_name)
      expect(new_instance.name).to eq('Black or White')
      expect(new_instance.artist.name).to eq('Michael Jackson')
    end
  end
end
