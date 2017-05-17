# Meowing Cat

## Objectives

1. Practice defining a class
2. Use macros to create setter and getter methods

![maru in a box](http://readme-pics.s3.amazonaws.com/tumblr_lm841mjEdz1qibxp4o1_500.jpg)

## Introduction

In this lab, you'll be creating a Cat class. Every instance of a Cat should have
a name and be able to meow. In other words, I should be able to do:

```ruby
maru = Cat.new
maru.name = "Maru"

maru.name
# => "Maru"

maru.meow
# "meow!"
# => nil
```

## Instructions

Run the test suite to get started. You'll be writing all your code in the `lib/meowing_cat.rb` file.

1. Define a class, called Cat.
2. Use the `attr_accessor` macro to create a setter and getter method for a cat's name.
4. Write a method, `.meow`, that outputs "meow!" to the terminal using the `puts` method when called on an instance of Cat.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-meowing-cat' title='Meowing Cat'>Meowing Cat</a> on Learn.co and start learning to code for free.</p>
