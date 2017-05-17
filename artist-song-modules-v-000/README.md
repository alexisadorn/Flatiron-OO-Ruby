# Refactoring with Modules

## Objectives

1. Recognize "code smells" that indicate the need for refactoring.
2. Use modules to refactor away repetitious code.

## Overview

In this lab, we have a similar domain model to that of Playlister. We have an `Artist` class and a `Song` class. `Artists` have many songs and an individual instance of the `Song` class belongs to an artist. `Artist`s and `Song`s also have some familiar class methods that keep track of all of the instances of the class, count those instances and clear or reset them.

Open up the `lib` directory and spend some time reviewing the code in `artist.rb` and `song.rb`. Keep reading the code until you feel you understand what each method is doing.

Notice that there are behaviors that are shared between both of these classes. For example, both classes have `.count` and `reset_all` class methods. Consequently, both classes have *the same exact code*. As programmers, you may recall, we are lazy. We don't like to repeat ourselves. We like to keep it DRY (Don't Repeat Yourself). In this lab, we'll be identifying repetition and building modules to extract it out. Then, we'll use the `extend` and `include` keywords to lend the functionality of our modules to our `Artist` and `Song` classes.

## Configuring our Environment

Instead of requiring individual files within one another, as you may have noticed we did in the previous two code along exercises, we created an environment file to handle those requirements for us. Open up the `config` directory and look at the `environment.rb` file. You'll see that we're already requiring the files that hold our `Artist` and `Song` class. Any additional files we make should be required by this `environment.rb` file. Our `spec_helper` file, which is required by each individual spec file, required *only this `config/environment.rb` file*, instead of each and every file from the `lib` directory. As we start to build larger and more complex programs, it begins to make sense to handle all of our requirements in one place.

## Instructions

### A Note on Refactoring Practices

We use TDD (test-driven development) for a reason. We write tests to define the desired behavior of our program so that we can write clean, beautiful code. Such code usually *isn't* the code you write the first time around. The code you first write is the code that makes your program *work*, the code that gets those tests passing. Then, we refactor our code to make it clean, DRY, and easy to understand. This is where our tests come in. If we write thorough tests that cover all of the aspects of our code's desired behavior. We can *first* write code that passes those tests and *then* break our code, fail our tests, write better code and pass our tests again.

This is called the **red, green, refactor** pattern. First tests fail, then you write bad code to get them to pass, *then* you refactor that bad code into good code. In this lab, you'll start by running the test suite. You'll see that all of the tests pass. Then, we'll break that code in order to refactor it, write better code and get our tests passing again. Remember, don't be afraid of broken code! Broken code is the status quo in programming. Your job is often to break something to make it better. Embrace broken code.

### Step 1: Class Methods

First, run the test suite. Wow, we're passing all of our tests! Okay, now let go of those passing tests because we are about to break our code.

The first area of refactoring we'll be attacking are the class methods. Notice that both the `Song` and `Artist` class have `.count` and `reset_all` class methods. Instead of repeating the same exact code in both classes, let's extract these class methods into a module that we can *extend* into the classes.

Ready to break your code? Comment out the `reset_all` and `count` methods in the `Song` and `Artist` class. Run your test suite. Phew! Okay, we did it. That wasn't so bad, was it?

#### The `Memorable` Module

Let's define our module. Create a `concerns` folder inside `lib`. This is where we'll store our modules. It is a common practice to create a folder called `concerns` that holds modules that will be used across classes in an object oriented Ruby project.

Inside the `concerns` folder, create a file called `memorable.rb`. Open up that file and define a module:


```ruby
module Memorable
end
```

Inside here, define your `reset_all` and `count` methods. 

Important! Remember to add `require_relative '../lib/concerns/memorable'` to your environment file before running any tests. We've already provided that line for you in fact! All you have to do is un-comment it out. :)

Once you define the two class methods mentioned above inside of the `Memorable` module, use the `extend` keyword to extend those methods, as class methods, into both the `Artist` and `Song` class. Refer to the previous code along exercise for help.

Now you're ready to run your test suite again. Get all those tests back to passing before you move on. Once your tests are passing, make sure you delete the commented-out `reset_all` and `count` class methods from your `Song` and `Artist` class. You don't need them anymore.

#### Advanced: The `find_by_name` Method

Before we build the module to house this method, let's talk a bit about it. In an upcoming unit, we'll be introducing databases. You'll learn how to connect your Ruby programs to a database and use that database to store information––even Ruby objects! Moving forward through this course, you'll be building web applications that are connected to databases that store users' information and the information pertinent to the app. Let's think about a common example:

Let's say you're working on an app that serves as an online store, connecting users to everything from books to movies to shoes to stereo equipment, you name it. We'll call this app "Nile" (definitely not inspired by another online market-place named after a famous river). Such an application needs to store the items it has for sale as well as the information of the user who logs in to go shopping. Consequently, every time a user logs in, or searches for an item, or purchases an item, we have to *retrieve information from a database*. One of the most common ways you'll be doing that is to use methods like `find_by_name` or `find_by_email` or `find_by_product_id` or...you get the idea. We'll be learning much, much more about this later. Here, we're building a simple `find_by_name` method that introspects on a class's `.all` class method and extracts the instance of the class with a certain name.

Okay, back to your regularly scheduled programming:

#### The `Findable` Module

In `lib/concerns`, create a file, `findable.rb`. In this file, define a module: `Findable`. This module should define the method, `find_by_name`. This method will be used as a class method. Something like this:

```ruby
Artist.find_by_name("Adele")
#=> #<Artistx038230sdcmdn3872>
```

Extract the code from the `find_by_name` methods that you'll see in the `Artist` and `Song` classes and place it inside the `Findable` module's `find_by_name` method. 

Remember that we need to keep the content of this method abstract. So, inside the `Artist` class, a `find_by_name` method might look like this:

```ruby
class Artist

  @@artists = []
  
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def self.all
    @@artists
  end
  
  def self.find_by_name(name)
    @@artists.detect {|a| a.name == name}
  end
end
```

Inside the `Findable.find_by_name` method, we can't use a class-specific class variable like `@@artists`, because our method would break when included in any class that *didn't* define such a variable. 

Is there a way to reference the collection of *all* of the instances of a class, without specifically referencing class variables that are only defined in certain classes?


### Step 2: Instance Methods

Let's go back to our `Song` and `Artist` class and take a look at another example of repetition, this time with instance methods. The `to_param` instance method is repeated in the `Song` and `Artist` class. Another great candidate for refactoring!

Go ahead and comment out the `to_param` method in both the `Song` and `Artist` class. Run your test suite again and see those broken tests!

Okay, now we're ready to define our module.

#### The `Paramable` Module

Create a new file in your `concerns` directory called `paramable.rb`. Define your module here:

```ruby
module Paramable
end
```

Build the `to_param` method inside your module and use the `include` keyword to include the `Paramable` module in both the `Song` and `Artist` class. Once you get your tests passing again, go ahead and delete the commented-out `to_param` method from the `Song` and `Artist` classes.

Important! Remember to add `require_relative '../lib/concerns/paramable'` to your environment file before running any tests. We've already provided that line for you in fact! All you have to do is un-comment it out. :)


#### Advanced: The `to_param` Method

To understand the concept of a parameter, let's take a look at an example URL: www.facebook.com/your-name.

The "your-name" part of the above URL might be referred to as a slug. Another term for this section of a URL is "parameter" or "param". One common task you'll undertake as a web developer is to take a Ruby object, such as an instance of a `User` class, and make a URL out of it. For example, let's say we have a database full of instances of a `User` class. When an individual user signs in to our app, we might want to show them their very own profile page. To do so, we would have to write a method that takes their name and turns it into a slug or parameter that could be tacked onto a URL.

Don't worry too much about this use-case for now. We'll be learning much, much more about connecting our Ruby programs to the web later on. For now, just understand the general purpose of having a method like the `to_param` method.

### Bonus: Refactoring the `.initialize` Method

#### Recognizing Repetition

Let's take a look at the `.initialize` methods of both the `Song` and `Artist` class:

#### `lib/song.rb`

```ruby
 def initialize
    @@songs << self
  end
```

#### `lib/artist.rb`

```ruby
def initialize
    @@artists << self
    @songs = []
  end
```

See the repetition? Both methods push the instance on which they are being called, i.e. `self` into an array stored inside a class variable.

In `song.rb` we have:

`@@songs << self`

In `artist.rb` we have:

`@@artists << self`


This is pretty similar, although not exactly the same. However, it is repetitious enough to be giving off a code smell. In order to refactor it, however, we first have to get rid of any code that is specific to the class. In this case, we need to abstract away the literal reference to the `@@songs` and `@@artists` class variables.

#### Abstracting Away Repetition

Lucky for us, we already have class methods that wrap these class variables:

#### `lib/song.rb`

```ruby
 def self.all
    @@songs
 end
```

#### `lib/artist.rb`

```ruby
def self.all
    @@artists
end
```

Let's begin by refactoring the content of both `.initialize` methods to use the `<ClassName>.all` class method instead of literal class variables. How can we programmatically access the class of the instance that we are operating on inside the `.initialize` method? Take a look below:

#### `lib/song.rb`

```ruby
def initialize
    self.class.all << self
end
```

#### `lib/artist.rb`

```ruby
def initialize
    self.class.all << self
    @songs = []
end
```

Remember that `.initialize` is an instance method. So, inside `.initialize`, `self` refers to the instance of the class on which you are operating. But `.all` is a class method. We would normally call it like this:

`Artist.all`

or

`Song.all`

So, to call the `.all` class method from *inside the `.initialize` instance method*, we can call `self.class` inside `.initialize`.

Take a quick look at this reminder of how `.class` works:

```ruby
new_song = Song.new
new_song.class
 => Song
```

So, we can call `self.class.all` inside `.initialize` and it will be just as if we called `Song.all` or `Artist.all`. Only this way, our code is abstract. It doesn't explicitly reference `Song` or `Artist` class, so it is more flexible.

Now we have two `.initialize` methods that contain identical lines of code. We're ready for the next refactoring step––modules.

#### Extracting Repetition

Before we build a brand new module to house this code from our `.initialize` methods, let's stop and think. What is the responsibility or the behavior of the code we are trying to extract? This is code that is responsible for telling a class to keep track of its own instances. This code really goes hand in hand with the `.count` and `.reset_all` class methods that we already extracted into the `Memorable` module. It makes sense, therefore, to extract this code into that same module.

But wait (you might be thinking), isn't that module **extended** into our `Song` and `Artist` class in order to offer its methods as **class** methods? Isn't `.initialize` an instance method? How can we put class methods and instance methods in the same module? Read on to learn the answer...

#### Nesting Modules

We can nest sets of modules within one another and then `include` or `extend` individual modules as needed. Let's take a look:

```ruby
module Memorable
  module ClassMethods
    def reset_all
      self.all.clear
    end

    def count
      self.all.count
    end
  end

  module InstanceMethods
    def initialize
      # some more code coming soon!
    end
  end
end
```

Then, in order to `include` or `extend` as needed, we use the `include` or `extend` keyword in the following manner:

In both the `Song` and `Artist` classes:

```ruby
extend Memorable::ClassMethods
include Memorable::InstanceMethods
```

The `Parent::Child` syntax is called **namespacing**.

Okay, we're almost done. We need to fill out the content of the `.initialize` method in the module.

The `.initialize` methods in our `Song` and `Artist` classes share the following line:

```
def initialize
  self.class.all << self
end
```

This is the code that will go into the new `.initialize` method of our module:

```ruby
module Memorable
  module ClassMethods
    def reset_all
      self.all.clear
    end

    def count
      self.all.count
    end
  end

  module InstanceMethods
    def initialize
      self.class.all << self
    end
  end
end
```

There's just one more step. Look back at the original `.initialize` method of the `Artist` class:


```ruby
class Artist
  ...

  def initialize
    self.class.all << self
    @songs = []
  end
```

In the `Artist` class, the initialize method is *also* responsible for setting the `@songs` instance variable equal to an empty array. We need to hang on to this behavior, even as `Artist` instances grab the *rest* of the `.initialize` from the `Memorable::InstanceMethods` module.

Remember our `super` keyword from the inheritance code along exercise? The `super` keyword, placed inside a method, will tell that method to look up its behavior in the method of the same name that lives in the parent, or super, class. A method that includes the `super` keyword will execute any code placed inside the super class' method of the same name, and then execute any code inside the child class' method.

When we `include` a module in a class, we are really telling that class to *inherit* methods from that module.

So, we can use the `super` keyword to tell our `Artist`'s `.initialize` method to use the code in the `Memorable::InstanceMethods` module's `.initialize` method *and* also to use any additional code in the `Artist`'s `.initialize` method. Take a look:

```ruby
class Artist
  ...

  def initialize
    super
    @songs = []
  end
```

## Conclusion

Phew! That was some complex stuff. It's okay if you didn't understand everything covered in this lab. There were a few advanced and bonus sections that we threw in there to challenge you and make you think. Don't skip over them, even if you can't follow everything they discuss. It's important to plant the seed of some of these more complex topics––it will make them easier to understand later on when you're ready to go deeper into Ruby programming.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/artist-song-modules' title='Refactoring with Modules'>Refactoring with Modules</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/artist-song-modules'>Intro to Modules Lab</a> on Learn.co and start learning to code for free.</p>
