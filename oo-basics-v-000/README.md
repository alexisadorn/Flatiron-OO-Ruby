

# Object Orientation Basics

## Description

This lab will walk you, step by step, through the basics of programming a simple `Book` class. Once you've completed the tutorial, you should know enough to complete a similar object oriented problem on your own.

## Instructions

1. Read through the tutorial, following along as you go.
2. Once you've finished, make the tests in `spec/01_book_spec.rb` pass. Run only those tests by typing `learn spec/01_book_spec.rb` on your command line.

## Tutorial

Object oriented programming, or OOP, is an extremely useful programming paradigm in which we can organize our code according to how real-world objects might interact with one another. We can wrap properties/data and behavior up in classes, and then create instances, or individual "members", of those classes that can interact with one another.

One common misperception about OOP is that everything MUST model the _real
world_. If we limit our objects to things in the real world, the
limitations will start jumping out at us.

Imagine a phone call between 2 people. Sure, the PEOPLE are real, but what about the phone call? If we think
about the phone call through OOP, we can model it too! A phone call has a
`caller` and a `receiver`, a `duration`, and even a `cost_per_minute`. In the _real world_, it's not a real thing, but in OOP IT IS!

In this tutorial, our goal is to create a simple `Book` class. We'll want it to have properties like a title, an author, a page count, etc. We'd also like the class to somehow be able to keep track of all of the genres of all of the Books we create. Finally, we'll give our books the total non-sensical ability to turn their own pages.

### Set Up

The project directory structure is pretty much set up for us already. We have a `spec` folder that contains our tests, and we have a `book.rb` file in the 'lib' directory that we'll actually be coding in.

Whenever the tutorial says to 'run the specs', you should type the following into your command line:

```bash
learn spec/01_book_spec.rb
```

This will run only the tests that we are interested in completing for this tutorial.

Ready?

### Running the Tests

Let's run the tests for the first time, and see what our first failure is. The output in your terminal should be something similar to:

```bash
Failures:

  1) Book ::new gets initialized with a title
     Failure/Error: expect{Book.new("And Then There Were None")}.to_not raise_error
       expected no Exception, got #<NameError: uninitialized constant Book> with backtrace:
         # ./spec/01_book_spec.rb:6:in `block (4 levels) in <top (required)>'
         # ./spec/01_book_spec.rb:6:in `block (3 levels) in <top (required)>'
     # ./spec/01_book_spec.rb:6:in `block (3 levels) in <top (required)>'
```

This looks kind of crazy, but the phrase `uninitialized constant Book` holds the answer: we need to define our Book class!

### Defining the Book Class

To create a new class in Ruby, we use the `class` keyword, followed by the name of a class
starting with a capital letter. Let's define an empty `Book` class in `book.rb`:

```ruby
# book.rb

class Book
end
```

Not too hard, right? Let's run those tests again and see what happens:

```bash
1) Book ::new gets initialized with a title
     Failure/Error: expect{Book.new("And Then There Were None")}.to_not raise_error
       expected no Exception, got #<ArgumentError: wrong number of arguments (1 for 0)> with backtrace:
         # ./spec/01_book_spec.rb:6:in `initialize'
         # ./spec/01_book_spec.rb:6:in `new'
         # ./spec/01_book_spec.rb:6:in `block (4 levels) in <top (required)>'
         # ./spec/01_book_spec.rb:6:in `block (3 levels) in <top (required)>'
     # ./spec/01_book_spec.rb:6:in `block (3 levels) in <top (required)>'
```

Hmm...an argument error? That's weird. In the test it looks like we're trying to initialize a new book (create a new book) using the following line of code:

```ruby
Book.new("And Then There Were None")
```

Now, I have no clue what "And Then There Were None" is in the context of our Book class, but what this is telling us is that somehow our Book needs to accept an argument on initialization.

I'm going to go out on a limb and guess that "And Then There Were None" is a title, so let's agree to call that argument `title`.

How exactly do we pass an argument in on initialization, though? Enter the `initialize` method!

### Initialize

The `initialize` method is what is known as a "hook" or a "callback". In other words, it is a method that gets triggered automatically when something else happens. In the case of `initialize`, it gets triggered when we call `.new` on a class. It also happens to be the method that we can pass arguments to when initializing a new instance of a class.

Let's add an initialize method to our book class, like this:

```ruby
# book.rb

class Book

  def initialize(title)
  end

end
```

We'll figure out what we need to do with `title` in just a minute, but for now, all we should remember is that the `initialize` method is a place that we'll probably be doing some setup in. Cool?

Let's run those tests again:

```bash
1) Book properties has a title
     Failure/Error: expect(book.title).to eq("And Then There Were None")
     NoMethodError:
       undefined method `title' for #<Book:0x00000101d94d90>
     # ./spec/01_book_spec.rb:14:in `block (3 levels) in <top (required)>'
```

Hey, look! That test passed, and we're on to a different one!

### Giving a Book a Title

It looks like we don't have a method `title` for our book. We know how to fix this error... we're just writing Ruby, after all. Let's write a `title` method in our `Book` class:

```ruby
# book.rb

class Book

  def initialize(title)
  end

  def title
  end

end
```

And if we run the specs again, we see this output:

```bash
1) Book properties has a title
     Failure/Error: expect(book.title).to eq("And Then There Were None")
       
       expected: "And Then There Were None"
            got: nil
       
       (compared using ==)
     # ./spec/01_book_spec.rb:14:in `block (3 levels) in <top (required)>'
```

So, it seems like, if I'm reading the test correctly, we are initializing a book with "And Then There Were None" as an argument, and then magically, when we call `title` on that book, it should return "And Then There Were None".

This means that somewhere between calling `.new` and `.title`, our book is somehow getting assigned a title. Where *must* that be happening, then?

In the `initialize` method! It really can't happen anywhere else.

### Instance Variables

This is where instance variables come into play. Instance variables are preceded with an "@" symbol, and are in scope within an instance of a class. This means that any method within an instance has access to any instance variable. This is awesome, because within our instances, we don't need to worry about passing variables around. Sweet, huh?

You can also, sort of, think of instance variables as properties of any particular instance of a class. Our book seems to have a `title` property, so let's create a `@title` instance variable for it! We'll do that in the initialize method.

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
  end

end
```

Easy as pie. Run those specs again and let's see what happens:

```bash
1) Book properties has a title
     Failure/Error: expect(book.title).to eq("And Then There Were None")
       
       expected: "And Then There Were None"
            got: nil
       
       (compared using ==)
     # ./spec/01_book_spec.rb:14:in `block (3 levels) in <top (required)>'
```

Hmm...that looks awfully familiar. It seems like our `title` method is still returning `nil`.

But, wait. Didn't we just set an instance variable, or property, in our initialize method?

We so did, but we also forgot to, you know, use it in any way. If when we call `.title` on a Book instance, we're interested in its title property, maybe we should just return that property, or instance variable, in that method?

Let's do that (the difference is in the `title` method):

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

end
```

Run the specs, and boom! New error:

```bash
Failures:

  1) Book properties has an author name
     Failure/Error: book.author = "Agatha Christie"
     NoMethodError:
       undefined method `author=' for #<Book:0x00000102ba9188 @title="And Then There Were None">
     # ./spec/01_book_spec.rb:18:in `block (3 levels) in <top (required)>'
```

### Setter Methods

That's a weird looking "undefined method" error. It says we have no `author=` method.

What? That's gotta be a mistake, right? Nope.

Let's step back for a second. That `title` method we wrote before is what is called a "getter". We call it this because, well, it "gets" a property for us. But what happens if we want to, say, *set* a property, or an instance variable? This is where "setters" come into play.

Setters are methods that allow us to set instance variables. It seems weird, but they all are named like this: `property=`. This is because Ruby gives us a nice bit of syntactic sugar that allows us to use these methods like:

```ruby
instance.property = "something"
```

Cool, huh?

So if we want to give our books an author, they need to also have a setter method for author. Let's add one to our class. And, since we know all about instance variables, let's go ahead and set an instance variable, `@author` within that method:

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

end
```

What happens if we run the specs now?

```bash
Failures:

  1) Book properties has an author name
     Failure/Error: expect(book.author).to eq("Agatha Christie")
     NoMethodError:
       undefined method `author' for #<Book:0x00000101cf1140>
     # ./spec/01_book_spec.rb:19:in `block (3 levels) in <top (required)>'
```

### Setters and Getters Usually (well, sometimes, mostly, kinda) Come in Pairs

Now it looks like we're missing an `author` method. Just like with `title`, if we want to access a property of our book, we need a getter for that property. For this reason, getters and setters tend to come in pairs. This is definitely not a hard and fast rule, but for our purposes now, it's a general rule of thumb we can live by.

Let's go ahead and add the "getter" for `author` to our book:

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

  def author
    @author
  end

end
```

And another run of the tests gives us this:

```bash
Failures:

  1) Book properties has a page count
     Failure/Error: book.page_count = 272
     NoMethodError:
       undefined method `page_count=' for #<Book:0x000001023b43d8 @title="And Then There Were None">
     # ./spec/01_book_spec.rb:23:in `block (3 levels) in <top (required)>'
```

Hey, look! We know how to fix this! It looks like our model (class) needs a setter (and probably a getter) for `page_count`. Let's add both of those now:

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

  def author
    @author
  end

  def page_count=(num)
    @page_count = num
  end

  def page_count
    @page_count
  end

end
```

Another run of the specs gives us a very similar error for `genre=`. Let's also add a setter and a getter for that property:

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

  def author
    @author
  end

  def page_count=(num)
    @page_count = num
  end

  def page_count
    @page_count
  end

  def genre=(genre)
    @genre = genre
  end

  def genre
    @genre
  end

end
```

Run Learn now, and we get the following:

```bash
1) Book #turn_page can turn the page
     Failure/Error: book.turn_page
     NoMethodError:
       undefined method `turn_page' for #<Book:0x0000010145b350 @title="The World According to Garp">
     # ./spec/01_book_spec.rb:37:in `block (3 levels) in <top (required)>'
```

### Giving Our Classes Behavior

So, this is pretty silly. Books can't turn their own pages, but we'll use the missing `turn_page` method to demonstrate that we don't only give our classes properties.

Like I said above, OOP gives us the opportunity to encapsulate both data *and* behavior within our classes. Here, we want to be able to make our books turn their pages.

How do we give our books a behavior? Well, we give them methods that do stuff! So, let's give our book a `turn_page` method:

```ruby
# book.rb

class Book

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

  def author
    @author
  end

  def page_count=(num)
    @page_count = num
  end

  def page_count
    @page_count
  end

  def genre=(genre)
    @genre = genre
  end

  def genre
    @genre
  end

  def turn_page
  end

end
```

A quick run of the tests gives us this:

```bash
1) Book #turn_page can turn the page
     Failure/Error: expect($stdout).to receive(:puts).with("Flipping the page...wow, you read fast!")
       (#<IO:0x0000010106ac00>).puts("Flipping the page...wow, you read fast!")
           expected: 1 time with arguments: ("Flipping the page...wow, you read fast!")
           received: 0 times with arguments: ("Flipping the page...wow, you read fast!")
     # ./spec/01_book_spec.rb:35:in `block (3 levels) in <top (required)>'
```

It looks like our `turn_page` method doesn't really need to *do* much aside from print something to the screen. So, to make the test pass, let's add a `puts` statement to our `turn_page` method:

```ruby

# book.rb

class Book
  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def author=(author)
    @author = author
  end

  def author
    @author
  end

  def page_count=(num)
    @page_count = num
  end

  def page_count
    @page_count
  end

  def genre=(genre)
    @genre = genre
  end

  def genre
    @genre
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

end
```

This means that we can very easily tell our books to turn the page, like this:

```ruby
book = Book.new("Some Title")
book.turn_page
# => "Flipping the page...wow, you read fast!"
```

Run the tests, and, boom! All the tests pass!

### Final Steps

So, yay! We've passed the tests, but our simple class is looking kind of, umm, long, no?

We seem to have a bunch of setters and getters that look really, really similar aside from their name. There's got to be a better way.

And there is!

#### Attribute Accessors and Attribute Readers

This is where Attribute Accessors and Attribute Readers come into play. (There are also Attribute Writers, but we don't need them for this tutorial.)

This is a really simplistic explanation, but here's what they do:

1. Attribute Readers
  * Attribute readers give us a getter, or reader, for free.
  * In other words, if we have an attribute reader (`attr_reader`) for `:name`, Ruby will create a `name` method for us.
2. Attribute Accessors
  * Attribute accessors give us both a getter and a setter for free!
  * In other words, if we have an attribute accessor (`attr_accessor`) for `:name`, Ruby will create both `name` and `name=` methods for us.

We can really, really simplify our code now! Since the `author`, `page_count`, and `genre` setters or getters do not do anything special (they just set properties), we can turn those into `attr_accessors`:

```ruby
# book.rb

class Book
  attr_accessor :author, :page_count, :genre

  def initialize(title)
    @title = title
  end

  def title
    @title
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

end
```

Our `title` reader (or getter) is also super basic, so let's add an
`attr_reader` for it. Remember, this will give us a getter method
for free!

```ruby
# book.rb

class Book
  attr_accessor :author, :page_count, :genre
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def turn_page
    puts "Flipping the page...wow, you read fast!"
  end

end
```

### Wrap Up

And there you have it! We created a pretty simple Book class that has a bunch of properties, and even turns its own page! Now it's your turn to try some of this on your own.

## Shoe Class

Open `spec/02_shoe_spec.rb` and start making the tests pass. Write your code in `shoe.rb`.

To run the specs, type `learn spec/02_shoe_spec.rb` on your command line.

Happy coding!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-basics' title='Object Orientation Basics'>Object Orientation Basics</a> on Learn.co and start learning to code for free.</p>
