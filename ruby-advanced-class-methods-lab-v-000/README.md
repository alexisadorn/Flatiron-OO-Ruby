# Ruby Advanced Class Methods Lab

## Objectives

1. Build custom class constructors.
2. Build class finders.
3. Build class operators.

## Instructions

This lab has provided you with a base `Song` class that provides the following definition:

```ruby
class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

end

```

The `Song` class provides a class variable `@@all` to store all instances for `Song` that are created through the instance method `Song#save`. Additionally, `Song` instances have basic properties of a name and an artist name.

You have to build class methods that interact on the class data of `@@all` and provide the rest of our program with a semantic API on the `Song` class with methods such as `Song.find_or_create_by_name("Blank Space")`.

### `Song.create`

Build a class constructor `Song.create` that initializes a song and saves it to the `@@all` class variable either literally or through the class method `Song.all`. This method should return the song instance that was initialized and saved.

Consider:

```ruby
song = Song.create
Song.all.include?(song) #=> true
```

### `Song.new_by_name`

Build a class constructor `Song.new_by_name` that takes in the string name of a song and returns a song instance with that name set as its name property. `Song.new_by_name` should return an instance of `Song` and not a simple string or anything else. Implement the following functionality:

```ruby
song = Song.new_by_name("The Middle")
#=> #<Song @name="The Middle">
song.name #=> "The Middle"
```

### `Song.create_by_name`

Build a class constructor `Song.create_by_name` that takes in the string name of a song and returns a song instance with that name set as its name property and the song being saved into the `@@all` class variable.

Consider:

```ruby
song = Song.create_by_name("The Middle")
#=> #<Song:0x007fd2a2989ff0 @name="The Middle">
song
#=> #<Song:0x007fd2a2989ff0 @name="The Middle">
Song.all.include?(song)
#=> true
```

### `Song.find_by_name`

Build a class finder `Song.find_by_name` that accepts the string name of a song and returns the matching instance of the song with that name. Consider:

```ruby
the_middle = Song.create_by_name("The Middle")
#=> #<Song @name="The Middle">

Song.find_by_name("The Middle")
#<Song @name="The Middle">
```

### `Song.find_or_create_by_name`

In order to prevent duplicate songs being created that actually represent the same song (based on the song name), we're going to build a `Song.find_or_create_by_name` class method. This method will accept a string name for a song and either return a matching song instance with that name or create a new song with the name and return the song instance.

Consider:

```ruby
song_1 = Song.find_or_create_by_name("Blank Space")
song_2 = Song.find_or_create_by_name("Blank Space")

# song_1 and song_2 are conceptually the same song and should return the same song instance because of `.find_or_create_by_name.`

song_1 == song_2 #=> true
```

### `Song.alphabetical`

Build a class method `Song.alphabetical` that returns all the songs in ascending (a-z) alphabetical order.

Use [Array#sort_by](http://ruby-doc.org/core/Enumerable.html#method-i-sort_by).

### `Song.new_from_filename`

Build a class constructor that accepts a filename in the format of "<Artist Name> - <Song Name>.mp3", for example "Taylor Swift - Blank Space.mp3".

Given `Song.new_from_filename("Taylor Swift - Blank Space.mp3")`, the constructor should return a new `Song` instance with the song name set to Blank Space and the artist_name set to Taylor Swift. The filename input sent to `Song.new_from_filename` in the format of `Taylor Swift - Blank Space.mp3` must be parsed for the relevant components. Separate the artist name from the rest of the data based on the ` - ` delimiter. Don't forget that when you parse the song name, you have to remove the `'.mp3'` part of the string.

```ruby
song = Song.new_from_filename("Taylor Swift - Blank Space.mp3")
song.name #=> "Blank Space"
song.artist_name #=> "Taylor Swift"
```

### `Song.create_from_filename`

Build a class constructor that accepts a filename in the format of "<Artist Name> - <Song Name>.mp3", for example "Taylor Swift - Blank Space.mp3". The `Song.create_from_filename` class method should not only parse the filename correctly but should also save the Song instance that was created.

### `Song.destroy_all`

The `Song.destroy_all` class method should reset the state of the `@@all` class variable to an empty array thereby deleting all previous song instances.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-advanced-class-methods-lab' title='Ruby Advanced Class Methods Lab'>Ruby Advanced Class Methods Lab</a> on Learn.co and start learning to code for free.</p>
