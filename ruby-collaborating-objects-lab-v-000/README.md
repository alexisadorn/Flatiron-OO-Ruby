# Ruby Collaborating Objects Lab

## Objective

1. Gain a deeper understanding of object relations.
2. Build classes that interact with one another through associations and behavior.

## Instructions

This is a test-driven lab. Use the test file and test output to understand what is being asked of you as you follow the guidelines below.

In this lab, we'll be dealing with an `Artist` class, a `Song` class, and an `MP3Importer` class.

Because of the relationships between your classes, the `Artist` tests, i.e. the tests in `spec/artist_spec.rb`, rely on some code in the `Song` class and vice versa. So, as you proceed through solving this lab, you will go back and forth between coding in `Artist` and `Song`.

We recommend starting out by getting some of the initial `Artist` tests passing and switching to write code in the `Song` class as directed by the test output. Because of the complexity, let's walk through a guideline of how to think about the problem as you're building out the solution.

## Overview

You will be building an `Artist` class, a `Song` class, and an `MP3Importer` class. At the top level, you can think about what we'll be doing in 3 steps:

1. The MP3 Importer will parse all the filenames in the `db/mp3s` folder and send the filenames to the Song class
2. The Song class will be responsible for creating songs given each filename and sending the artist's name (a string) to the Artist class
3. The Artist class will be responsible for either creating the artist (if the artist doesn't exist in our program yet) or finding the instance of that artist (if the artist does exist).

Thinking about it this way will get us started. Let's take a deeper look.

###`MP3Importer` class
Let's start with the MP3 Importer. Build an `MP3Importer` class that parses a directory of files and sends the filenames to a song class to create a library of music with artists that are unique. To do this, you'll need two methods: `MP3Importer#files` and `MP3Importer#import`. Your `MP3Importer` class should also have a `path` attribute that gets set on initialization.

You should write code that responds to `MP3Importer.new('./db/mp3s').import`. Google around for how to get a list of files in a directory! Make sure you only get `.mp3` files.

Since we have to send the filenames to the `Song` class, we'll end up calling the following code in the `#import` method: `Song.new_by_filename(some_filename)`. This will send us to the `Song` class, specifically `Song.new_by_filename`.

###`Song` class
#### `Song.new_by_filename`
This method will do four things:

1. It must parse a filename to find the song name and artist name. (*Hint: every file separates the song and artist with a `" - "`*). Now we put those values to use.

2. From here, we will create a new song instance using the string we gathered from the filename.

3. We'll also want to associate that new song with an artist. To do this we'll use a helper method: `Song#artist=(artist_name)`.

4. Return the new song instance. 

You may have seen something similar in the past where we have the instance of the artist. If we had the artist object, we could simply assign the artist to the song with some code that looks like this: `our_song_instance.artist = our_artist_instance`. Since we only have the artist name as a string (not an instance of the Artist class), we'll create a method that takes in the name and gets the artist object. Let's call this `Song#artist=(artist_name)`.

#### `Song#artist_name=(name)`
This method will do two things. Both of these things will involve collaboration with the `Artist` class:

1. Turn the artist's name as a string into an artist object

    First we need to get the instance of the Artist class that represents that artist. There are two possibilities here:

    1. Either we have to create that artist instance
    2. Or it already exists and we have to find that artist instance.

	To achieve this, we'll need to collaborate with the Artist class. We want to send the artist's name (a string--remember we are getting this from the parsed filename) to the Artist class to achieve the functionality described above in #1 and #2. Let's call this method `Artist.find_or_create_by_name(artists-name-here)`.

2. Assign the song to the artist (Since an artist has many songs, we'll want to make this association)

	 Now that we have the artist instance, we'll want to again collaborate with the `Artist` class by calling on the `Artist#add_song(some_song)` method.

###`Artist` class
It will probably be useful to create a couple of helper methods to assist with the methods below.

####`Artist.find_or_create_by_name(name)`
This class method should take the name that is passed in (remember, it will be a string), and do one of two things. Find the artist instance that has that name or create one if it doesn't exist. Either way, the return value of the method will be an instance of an artist with the name attribute filled out.

####`Artist#add_song(song)`
This instance method exists to tell the artist about its songs. Simply take the `Song` instance that is passed in as an argument and store it in a `songs` array with all the other songs that belong to the artist.


###Conclusion

These are just a few hints and guidelines to help you through this lab. Rely on the guides here, refer to the previous Code Along on object relations, and **read the test output and test files**. Never forget to ask a question on Learn if you are stuck. Good luck!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-collaborating-objects-lab'>Collaborating Objects Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/ruby-collaborating-objects-lab'>Collaborating Objects Lab</a> on Learn.co and start learning to code for free.</p>
