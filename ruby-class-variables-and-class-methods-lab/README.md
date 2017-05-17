# Ruby Class Variables And Class Methods Lab

## Objectives

1. Use class variables to keep track of data pertaining to a class.
2. Define class methods to expose data pertaining to a class.

## Overview

In this lab, we'll be dealing with a `Song` class. The `Song` class can produce individual songs. Each song has a name, an artist and a genre. We need our `Song` class to be able to keep track of the number of songs that it creates.

```ruby
Song.count
  # => 30
```

We need our `Song` class to be able to show us all of the artists of existing songs:

```ruby
Song.artists
  # => ["Jay-Z", "Drake", "Beyonce"]
```

We need our `Song` class to be able to show us all of the genres of existing songs:

```ruby
Song.genres
  # => ["Rap", "Pop"]
```

We also need our `Song` class to be able to keep track of the number of songs of each genre it creates.

In other words, calling:

```ruby
Song.genre_count
```

Should return something like this;

```ruby
{"rap" => 5, "rock" => 1, "country" => 3}
```

Lastly, we want our `Song` class to reveal to us the number of songs each artist is responsible for.

```ruby
Song.artist_count
  # => {"Beyonce" => 17, "Jay-Z" => 40}
```

We'll accomplish this with the use of class variables and methods.

## Instructions

* Define your `Song` class such that an individual song is initialized with a name, artist and genre.
* There should be an `attr_accessor` for those three attributes.

```ruby
ninety_nine_problems = Song.new("99 Problems", "Jay-Z", "rap")

ninety_nine_problems.name
  # => "99 Problems"

ninety_nine_problems.artist
  # => "Jay-Z"

ninety_nine_problems.genre
  # => "rap"
```

* Create a class variable, `@@count`. We will use this variable to keep track of the number of new songs that are created from the `Song` class. Set this variable equal to `0`.
* At what point should we increment our `@@count` of songs? Whenever a new song is created. Your `#initialize` method should use the `@@count` variable and increment the value of that variable by `1`.
* Write a class method, `.count`, that returns the total number of songs created.
* Write a class method, `.genres` that returns an array of all of the genres of existing songs. This array should contain only unique genres––no duplicates! Think about what you'll need to do to get this method working.
  * You'll need a class variable, let's call it `@@genres`, that is equal to an empty array.
  * When should you add genres to the array? Whenever a new song is created. Your `#initialize` method should add the genre of the song being created to the `@@genres` array. All genres should be added to the array. Control for duplicates when you code your `.genres` class method, not when you add genres to the original `@@genres` array. We will want to know how many songs of each genre have been created. We'll revisit that job a little later on.
* Write a class method, `.artists`, that returns an array of all of the artists of the existing songs. This array should only contain unique artists––no repeats! Once again think about what you need to do to implement this behavior.
  * You'll need a class variable, let's call it `@@artists`, that is equal to an empty array.
  * When should you add artists to this array? Whenever a new song is intialized. Your `#initialize` method should add artists to the `@@artists` array.  All artists should be added to the array.  Control for duplicates when you code your `.artists` class method, not when you add artists to the original `@@artists` array.  We will want to know how many songs each have been assigned to each artist.  We'll revisit that job a little later on when we write our `.artist_count` method.
* Write a class method, `.genre_count`, that returns a hash in which the keys are the names of each genre. Each genre name key should point to a value that is the number of songs that have that genre.

```ruby
Song.genre_count
  # => {"rap" => 5, "rock" => 1, "country" => 3}
```

This manner of displaying numerical data is called a [histogram](https://en.wikipedia.org/wiki/Histogram). How will you create your histogram? You will need to iterate over the `@@genres` array and populate a hash with the key/value pairs. You will need to check to see if the hash already contains a key of a particular genre. If so, increment the value of that key by one, otherwise, create a new key/value pair.

* Write a class method, `.artist_count`, that returns a histogram similar to the one above, but for artists rather than genres. 

<p class='util--hide'>View <a href='https://learn.co/lessons/ruby-class-variables-and-class-methods-lab'>Class Variables and Methods Lab</a> on Learn.co and start learning to code for free.</p>
