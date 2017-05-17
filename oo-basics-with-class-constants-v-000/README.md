# Object Orientation Basics With Class Constants

## Objectives
1. Understand what a class constant is
2. Use a class constant
3. Know when to use `attr_accessor` VS creating the methods yourself

## Description

Previously, we saw how to make each individual instance of a class hold on to the information about itself.  A book object, an instance of the `Book` class, knew its own title and author and genre.  Building upon that, you will learn to add functionality that allows a class to hold information from across all the instances of that class that have been created.

## Instructions

1. Read through the tutorial, following along as you go.
2. Once you've finished, make the tests in `spec/01_book_spec.rb` pass. Run only those tests by typing `learn spec/01_book_spec.rb` on your command line.

## Tutorial

In this tutorial, we are given a simple `Book` class that has already been implemented with some basic functionality. It has properties like a title, an author, a page count, etc. Our job is to have the class somehow be able to keep track of all of the genres of all of the Books we create.

### Class Constants

Let's run the tests for the first time, and see what our first failure is. The output in your terminal should be something similar to:

```bash
Failures:

  1) Book GENRES keeps track of all genres
     Failure/Error: expect(Book::GENRES).to include(genre)
     NameError:
       uninitialized constant Book::GENRES
     # ./spec/01_book_spec.rb:11:in `block (4 levels) in <top (required)>'
     # ./spec/01_book_spec.rb:10:in `each'
     # ./spec/01_book_spec.rb:10:in `block (3 levels) in <top (required)>'
```

Ok, so this is new. This syntax, `Book::GENRES` tells us a couple of things. First, whenever we see `::`, it indicates "name spacing". In other words, it tells us that the thing on the right side of the colons is a thing defined within the context, or name space, of the thing on the left side of the colons.

In this case, this is telling us that there is a constant, `GENRES` (we know it's a constant because it's written in all caps) that is defined within our `Book` class.

This is what is known as a Class Constant.

Class Constants are available to all instances of a particular class. Whereas instance variables, i.e. title, author, etc., are individual to each instance of a class, class constants are shared among **all** instances. They all have access to the same data, and if that data should change for some reason, all instances will know about that change.

Let's go ahead and define this constant. Since it's plural, I'm going to guess that it should be an array, so I'll start by defining it as an empty array:

```ruby
# book.rb

class Book
  attr_accessor :author, :page_count, :genre
  attr_reader :title

  GENRES = []

  def initialize(title)
    @title = title
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

end
```

This next error, after running the specs again, though is kind of weird:

```bash
Failures:

  1) Book GENRES keeps track of all genres
     Failure/Error: expect(Book::GENRES).to include(genre)
       expected [] to include "Thriller"
     # ./spec/01_book_spec.rb:11:in `block (4 levels) in <top (required)>'
     # ./spec/01_book_spec.rb:10:in `each'
     # ./spec/01_book_spec.rb:10:in `block (3 levels) in <top (required)>'
```

We really have no clue how in the world our array would magically contain "Thriller", so let's look at the specific test to figure out what's going on. Here's what we have in `spec/01_book_spec.rb`:

```ruby
describe 'GENRES' do
  it 'keeps track of all genres' do
    genres = ["Thriller", "Science Fiction", "Romance"]
    genres.each_with_index do |genre, i|
      book = Book.new("Book_#{i}")
      book.genre = genre
    end

    genres.each do |genre|
      expect(Book::GENRES).to include(genre)
    end
  end
end
```

So, it looks like what's going on is this:

1. The test is creating a bunch of books.
2. The test is assigning each of those books a genre.
3. The test is expecting our GENRES class constant to keep track of those genres.

Ok, so let's think about this for a second. Where in that sequence of events can `GENRES` be updated? Well, it can't be in step one. None of the books starts out having a genre. Maybe it happens in step two, but I'm not sure.

No, wait...it *has* to happen in step two. After the books are assigned their genres, nothing else happens before the test checks to see that `Book::GENRES` knows about those genres. What does this mean, then?

It means that something else needs to happen in our `genre=` method. We need to somehow update our `GENRES` constant in that method. Remember, our `genre=` method (along with our `genre` method) is created by the following line of code: `attr_accessor :genre`. Since we want to add some customization to the method, we'll have to do three things:

1. Explicitly define the `genre=` method, to integrate our class constant into the method
2. Remove the `attr_accessor` for `:genre` since we no longer need to generate a reader AND a writer.
3. Add an `attr_reader` for `:genre`, since we still want Ruby to generate a reader for us.


So, let's do that!

```ruby
# book.rb

class Book
  attr_accessor :author, :page_count  # remove the attr_accessor for genre
  attr_reader :title, :genre  # add an attr_reader for genre

  GENRES = []

  def initialize(title)
    @title = title
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

  # create the writer for genre and add the logic for the class constant
  def genre=(genre)
    @genre = genre
    GENRES << genre 
  end
end
```

Now all the tests will pass!
Try to complete the similar exercise below where the `Shoe` class can keep track of all of the brands of the different show objects.

## Shoe Class

Open `spec/02_shoe_spec.rb` and start making the tests pass. Write your code in `shoe.rb`.

To run the specs, type `learn spec/02_shoe_spec.rb` on your command line.

Happy coding!
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-basics-with-class-constants' title='Object Orientation Basics With Class Constants'>Object Orientation Basics With Class Constants</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-basics-with-class-constants'>OO Basics with Class Constants</a> on Learn.co and start learning to code for free.</p>