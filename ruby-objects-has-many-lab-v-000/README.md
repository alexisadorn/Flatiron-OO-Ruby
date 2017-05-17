# Ruby Objects Has Many Lab

## Objectives

1. Build out the has many/belongs to relationship between two classes. 
2. Build methods that use the has many/belongs to relationship between two classes. 
3. Use a class variable to track data about a class. 
4. Build a class method to expose data stored in a class variable. 

## Instructions

In this lab, we'll be dealing with two sets of classes. The `Artist` and `Song` class and the `Author` and `Post` class. An artist should have many songs and a song should belong to an artist. An author should have many posts and a post should belong to an author. 

Because of the has many/belongs to relationship between your classes, the `Artist` tests, i.e. the tests in `spec/artist_spec.rb`, rely on some code in the `Song` class and vice versa. The same is true of the tests for the `Author` and `Post` classes. So, as you proceed through solving this lab, you will go back and forth between coding in `Artist` and `Song` and between coding in `Author` and `Post`. 

We recommend starting out by getting some of the initial `Artist` tests passing and switching to write code in the `Song` class as directed by the test output. Then, once your `Artist` and `Song` tests are passing, do the same for `Author` and `Post`. 

This lab is primarily test-driven. So run the test suite with the `learn` command to get started. Read the test output very carefully to help guide you through. First, read through the guidelines below and refer back to them as you complete the lab. 

### Building the has many/belongs to relationship

How can an artist have many songs and a song belong to an artist? An individual song will need to have an `artist=()` and `artist` method and an individual artist will need to be initialized with an empty collection of songs. 

How can an author have many posts and a post belong to an author? An individual post will need to have an `author=()` and `author` method and an individual author will need to be initialized with an empty collection of posts.

#### The `#add_song_by_name` and `#add_post_by_title` Methods

To get the tests on these methods passing, you'll need to define methods that take in an argument of a name (or title), use that argument to create a new song (or post) and *then* associate the objects. 

For `add_post_by_title`, you'll want to make sure the body of the method associates the newly created post with an author and adds the post to the author's collection.

#### The `#artist_name` and `#author_name` Methods

Build the methods `some_song.artist_name` and `some_post.author_name` that return the names of the artist and author of the given song and post respectively.

These methods should use, or extend, the has many/belongs to relationship you're building out. If a song has an artist, you can call: `some_song.artist` and return an actual instance of the `Artist` class. Since every artist has a name, `some_song.artist.name` should return the name of the `Artist` instance associated with the given song. Your `#artist_name` method should utilize this relationship. 

**Note:** We like our code to be robust, i.e. not easily breakable. Make sure your `#artist_name` and `#author_name` methods will not break if the given song or post does not have an artist or author. In this case, your methods should return `nil`.  

### The `.song_count` and `.post_count` Methods

You'll be required to write a class method that tracks the total number of songs, tallied up from all of the existing artists. You'll be required to write a similar method for the `Author` class. 

How do we keep track of data regarding an entire class? With class variables! The `Artist` class should have a class variable, `@@song_count`. This variable should start out set equal to `0`. When should you increment this value? Anytime a new song is added to an artist. Your `.song_count` method should then return the value of the `@@song_count` variable. Build out the same logic for your `Author` class. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-objects-has-many-lab' title='Ruby Objects Has Many Lab'>Ruby Objects Has Many Lab</a> on Learn.co and start learning to code for free.</p>
