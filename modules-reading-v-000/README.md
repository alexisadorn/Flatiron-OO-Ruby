# Modules and Mixins in Ruby

## Objectives

1. Learn about modules––another way to lend functionality across classes.

## Introduction

In the previous lesson, we discussed the concept of inheritance. We learned that through subclasses, a certain class under a super class, the subclass has access to all of the methods of its parent. Inheriting one class from another makes sense. The subclass can be understood as a child or subordinate of the super class. For example, a car is a type of vehicle, so it makes sense for the `Car` class to *inherit* from the `Vehicle` class.

Let's think about a slightly different type of example, one that is less hierarchical. We could easily envision writing an app that models the environment of a dance performance. Such an app might have a `Dancer` class. Dancers, we know, perform dances. Similarly, we could imagine a little girl going to see the Nutcracker ballet one Christmas, coming home and wanting to practice all of the ballet moves from the show. So, we might write a `Kid` class in which an instance of that class, our little girl who has gone to see the ballet, should have access to all those ballet moves (her performance skill notwithstanding). This situation is not hierarchical, like our `Car` and `Vehicle` example. Instead, `Kid` and `Dancer` simply need to share some functionality, without being related in any other meaningful way.

This is where modules come in. Modules allow us to collect and bundle a group of methods and make those methods available to any number of classes. In this exercise, we'll be defining a `Dance` module and making it available to both the `Dancer` and `Kid` class.

## Code Along I: Including Module Methods as Instance Methods

***This is a code along exercise. Fork and clone this repo by clicking the Github link at the top of the page. Follow along with the walk-through below to get your code working. Get the tests to pass.***

### Step I: Defining Our Module

We'll code our `Dance` module inside the `lib/dance_module.rb` file. Open up that file and define your module with the following code:

```ruby
module Dance
end
```

Let's give our `Dance` module some fabulous moves:

```ruby
module Dance
  def twirl
    "I'm twirling!"
  end

  def jump
    "Look how high I'm jumping!"
  end

  def pirouette
    "I'm doing a pirouette"
  end

  def take_a_bow
    "Thank you, thank you. It was a pleasure to dance for you all."
  end
end
```

Okay, now we'll define our `Kid` class and tell it to *include* the capabilities of the `Dance` module.

### Step 2: Defining the Classes

Open up `lib/kid.rb` and define your `Kid` class:

```ruby
class Kid
end
```

Let's do the same for the `Dancer` class in `lib/dancer.rb`:

```ruby
class Dancer
end
```

Now we're ready to include our module in our classes:


### Step 3: Including the Module

To lend our two classes all of the methods of the `Dance` module, we use the `include` keyword:


```ruby
class Kid
  include Dance

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
```

```ruby
class Dancer
  include Dance

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end
```

If we use `include` keyword, we allow our classes to use all of the methods of the included module as *instance* methods. We'll talk about how to lend a module's methods as *class* methods in a minute.

Now that we've included the module, open up `bin/dance_party` and get familiar with following code:

```ruby
require_relative "../lib/kid.rb"
require_relative "../lib/dancer.rb"

angelina = Kid.new("Angelina")
mikhail_baryshnikov = Dancer.new("Mikhail")

puts "#{angelina.name} says: #{angelina.twirl}"
puts "#{mikhail_baryshnikov.name} says: #{mikhail_baryshnikov.take_a_bow}"
```

Now, run the file by typing `ruby bin/dance_party` and you should see the following output in your terminal:

```bash
Angelina says: I'm twirling!
Mikhail says: Thank you, thank you. It was a pleasure to dance for you all.
```

## Code Along II: Extending Module Methods as Class Methods

In order to lend a module's methods to a class as *class methods*, we use the `extend` keyword. Let's write yet another module that we can extend into our classes as class methods. For the purposes of this example, let's create a shareable class method, `metadata`, which will report on some pertinent (shared) information regarding both classes.

Open up the `lib/class_method_module.rb` and define the following module and methods:

```ruby
module MetaDancing

  def metadata
    "This class produces objects that love to dance."
  end
end
```

Let's `extend` this module into both the `Kid` and `Dancer` classes:

```ruby
class Dancer
  extend MetaDancing
end
```

```ruby
class Kid
  extend MetaDancing
end
```

Now, open up the bin/extending file and familiarize yourself with the following code:

```ruby
require_relative "../lib/kid.rb"
require_relative "../lib/dancer.rb"

puts Kid.metadata
puts Dancer.metadata
```

Run the file with `ruby bin/extending` and you should see the following output in your terminal:

```bash
This class produces objects that love to dance.
This class produces objects that love to dance.
```

Run the tests to make sure all of your tests are passing.

## Code Along III: Nested Modules

In the first code along, we built a module called `Dance`, which contained methods that we intended to be used as instances methods in the `Dancer` class.

In the second code along, we built the module `MetaDancing`, whose methods were intended to be used as class methods in the `Kid` and `Dancer` classes.

There are two drawbacks to this approach. First, if another developer looks at your modules, there is absolutely no way to determine how those methods are intended to be used. Are they class methods? Are they instance methods? Nobody knows!

Secondly, we had to build two separate modules that contained methods that were all related to the same functionality (dancing). But because there was no way to designate class methods versus instance methods, we were forced to define two separate modules, which violates the single responsibility principle. Wouldn't it be great if there was a way to define one module and specify which methods were intended as class methods and which methods as instance methods.

Guess what?? There is!! We're going to refactor the two modules into one, and use nested module namespacing to clarify our code.

```ruby
module FancyDance
  module InstanceMethods

    def twirl
      "I'm twirling!"
    end

    def jump
      "Look how high I'm jumping!"
    end

    def pirouette
      "I'm doing a pirouette"
    end

    def take_a_bow
      "Thank you, thank you. It was a pleasure to dance for you all."
    end
  end

  module ClassMethods

    def metadata
      "This class produces objects that love to dance."
    end
  end
end

```

First, we define our `FancyDance` module. Then, inside the `FancyDance` module, we define a second module, `InstanceMethods`. Inside the `InstanceMethods` module, we place all our methods that we intend to be used as instance methods (`twirl`, `jump`, `pirouette`, `take_a_bow`). Next, we define a second nested module (nested inside of `FancyDance`) called `ClassMethods`. Inside, we place the `metadata` method, which we intend to be used as a class method.

So how do we use these nested modules?

```ruby
class Dancer
  extend FancyDance::ClassMethods
  include FancyDance::InstanceMethods
end
```

```ruby
class Kid
  extend FancyDance::ClassMethods
  include FancyDance::InstanceMethods
end
```

*Note: remember to require the `fancy_dance.rb` file inside the `dancer.rb` and `kid.rb`, just like we did with our other file requirements.*

We refer to the name-spaced modules or classes with `::`. This syntax references the parent and child relationship of the nested modules.

Remember, `include` is used to add functionality to our classes via instance methods. The `InstanceMethods` module inside the `FancyDancy` module contains the methods `twirl`, `jump`, `pirouette`, and `take_a_bow`, which any instance of the `Dancer` or `Kid` class can do.

We can call:

```ruby
angelina = Dancer.new
angelina.twirl
// returns "I'm twirling!"
angelina.jump
// returns "Look how high I'm jumping!"

buster = Kid.new
buster.jump
// returns "Look how high I'm jumping!"
buster.take_a_bow
// returns "Thank you, thank you. It was a pleasure to dance for you all."

```

Because we _included_ the `FancyDance::InstanceMethods` nested module, we can call those instance methods on instances of our classes.

And `extend` is used to add additional functionality to our classes via class methods. We can now call the `metadata` class method on the `Dancer` and `Kid` classes:

```ruby
Dancer.metadata
// returns "This class produces objects that love to dance."
Kid.metadata
// returns "This class produces objects that love to dance."
```

## `::` versus`<`

Inheritance using the `<` syntax, implies that a class is a type of something. A `BMW` class should inherit from a `Car` class because a BMW is a type of car: `class BMW < Car`.

But what about the `::` that we're using for our modules? The `::` syntax just denotes a name-space. Doing `BMW::Car` just gives the `BMW` class access to all constants, instance methods, etc, without stating that a BMW is a type of car. The `::` syntax carries all public items over to the inheriting class or module.

That's it! Now that we are familiar with several methods of sharing code between classes, you're ready to move on to the next few labs.

## Conclusion

If you have a module whose methods you would like to be used in another class as __instance methods__, then you must __include__ the module.

If you want a module's methods to be used in another class as __class methods__, you must __extend__ the module.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/modules-reading' title='Intro to Modules'>Intro to Modules</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/modules-reading'>Intro to Modules</a> on Learn.co and start learning to code for free.</p>
