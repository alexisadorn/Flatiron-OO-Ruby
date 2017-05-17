# Instance Variables

## Objectives

1. Define instance variables.
2. Distinguish instance variables from local variables
3. Describe how instance variables give objects attributes and properties

## Overview

When we build objects through our own classes we know we can add behavior to the objects through instance methods. But how do we give our objects data? For example, how would we teach a dog what its name is? Or what breed it is? How do we put data inside of an instance of an object so that each dog can have its own name and own breed? How do we give objects attributes or properties?

##Instructions
Run your tests with `learn` to get an overview of what we are trying to do. Then follow along below for how to get your tests to pass.

## What Is An Instance Variable?

We've been working with variables for a while now. For example:

```ruby
bro_greeting = "Sup, bro?"
```

The code above sets a variable, `bro_greeting`, equal to the string `"Sup, bro?"`. Now we can use that variable to read and operate on that string.

```ruby
bro_greeting #=> "Sup, bro?"

bro_greeting.upcase #=> "SUP, BRO?"
```

The `bro_greeting` variable is what's known as a **local variable**, so named because it can only be accessed in a specific, local environment.

A local variable that is defined inside one method, for example, cannot be accessed by another method. In order to get around this limitation, we can use **instance variables** inside our Ruby classes.

An **instance variable** is a variable that is accessible in any instance method in a particular instance of a class.

## We Need Instance Variables

Let's say we have a class called `Dog` that is responsible for producing individual dog objects. We want each dog to be able to have a name and show its name. So we need to write some methods:

Open `dog.rb` inside the `lib` folder. This is where we'll create our Dog class. Type in the following code.

```ruby
class Dog
  def name=(dog_name)
    this_dogs_name = dog_name
  end

  def name
    this_dogs_name
  end
end
```

Here we've defined two instance methods, the `name=`, or "name equals" method, and the `name` method. The first method takes in an argument of a dog's name and sets that argument equal to a variable, `this_dogs_name`. The second method is responsible for reporting, or reading the name. The methods act as mechanisms to expose data from inside of the object to the outside world.

Our two methods therefore are responsible for "setting" and "getting" an individual dog's name.

Here's the functionality we want to achieve:

```ruby
lassie = Dog.new
lassie.name = "Lassie"

lassie.name #=> "Lassie"
```

Our new dog instance should be assigned a name and know its name.

In your `dog.rb` file add the above code. This should create a new dog instance, give it a name (Lassie) and try to access- or read- its name.

Run `learn` again. You should see an error message, with the following snippet inside it:

```
 `name': undefined local variable or method `this_dogs_name''
```

Uh-oh. Looks like the `#name` method doesn't know about the `this_dogs_name` variable from the `#name=` method. That is because `this_dogs_name` is a **local variable**. A local variable has a **local scope**. That means that it cannot be accessed outside of the method in which it is defined.

## Implementing Instance Variables

We define an instance variable by prefacing the variable name with an `@` symbol.

Instance variables are bound to an instance of a class. That means that the value held by an instance variable is specific to whatever instance of the class it happens to belong to. Instance variables hold information about an instance, usually an attribute of that instance, and can be called on throughout the class, without needing to be passed into other methods as arguments (as would be the case with local variables).

Let's refactor our `Dog` class to use an instance variable instead of a local variable to set and get an individual dog's name.

Open up `dog.rb` and change the `Dog` class in the following way:

```ruby
class Dog

  def name=(dogs_name)
    @this_dogs_name = dogs_name
  end

  def name
    @this_dogs_name
  end
end

lassie = Dog.new
lassie.name = "Lassie"

puts lassie.name

```

Run `learn` again and your tests should now be passing.

Why did it work? Inside the `#name=` method, we set the value of `@this_dogs_name` equal to whatever string is passed in as an argument. Then, we are able to call on that same instance variable in a totally separate method, the `#name` method.

## Conclusion

As we dive deeper into object oriented Ruby, we'll be using instance variables frequently to pass information around the instance methods of a class. Think of instance variables as the containers for instance-specific information. The ability of instance variables to store information and be accessible within different instance methods is one of the things that makes it possible for us to create similar, but unique objects in object orientated Ruby.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-instance-variables-lab' title='Instance Variables'>Instance Variables</a> on Learn.co and start learning to code for free.</p>
