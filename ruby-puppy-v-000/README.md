# Ruby Remembrance Lab

## Objectives

1. Use a class variable to keep track of every instance of a class that is created. 
2. Write a class method to access the list of all instances of a class, stored in a class variable. 

## Overview

The government has decided to start tracking every new puppy that is born, just like we track every new child who is born with a birth certificate. Because you're such a notoriously skilled programmer, you've been hired by the newly minted United States Department of Canines to write a program that will do just that. 

You need to write a program that stores each new puppy that is born. You will write a `Dog` class that initializes with a name and also stores each new instance of `Dog` that is instantiated. 

## Instructions

Code your solution in `lib/dog.rb`

This lab is primarily test-driven. Run the test suite with the `learn` command and follow the test output to get started.

Some guidelines: 

* You'll need to set a class variable equal to an empty array inside your class. Call your class variable `@@all`.  
* This array is the storage container for each instance of a `Dog` that gets created. In other words, every puppy that is born should get pushed into this array at the moment of instantiation––in the `#initialize` method! Use the `self` keyword inside the `#initialize` method to refer to the new dog you are trying to store in your `@@all` array. 
* You will need to write a class method, `.all`, that iterates over all of the individual dogs stored in the `@@all` array and `puts` out their name to the terminal. 

There is one method that we'll talk about together:

### The `.clear_all` Method

What happens if we want to clear out our list of existing dogs? It is not at all uncommon to want to "reset" or "restart" our program. You'll be building a class method, `.clear_all`, that does just that. This method should operate on the `@@all` array of existing dogs and empty that array. **Hint:** look up the `Array#clear` method. 

### A Note on Testing

In the test suite, you'll see this code:

```ruby
expect(Dog.class_variable_get(:@@all)).to match([])
``` 

Here, we are using the `.class_variable_get(name_of_class_variable)` method on the `Dog` class. This method introspects on the class on which it is called and retrieves the value of the class variable passed into the method as an argument. We use it here in the test suite to check that you do in fact set a class variable, `@@all`, equal to an empty array and that you fill that array up with new dogs as they are instantiated. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-puppy' title='Ruby Remembrance Lab'>Ruby Remembrance Lab</a> on Learn.co and start learning to code for free.</p>
