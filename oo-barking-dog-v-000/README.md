# Barking Dog

## Objectives

1. Practice defining a class
2. Build instance methods––both setter and getter

![dog cartoon](https://s3-us-west-2.amazonaws.com/web-dev-readme-photos/oo-labs/dog.jpg)

## Introduction

In this lab, you'll be creating a Dog class. Every instance of a Dog should have
a name and be able to bark. In other words, I should be able to do:

```ruby
fido = Dog.new
fido.name = "Fido"

fido.name
# => "Fido"

fido.bark
woof!
# => nil
```

## Instructions

Run the test suite to get started. You'll be writing all your code in the `lib/dog.rb` file.

1. Define a class, called Dog. 
2. Write a setter method, `.name=`, that allows you to give a dog a name. 
3. Write a getter method, `.name` that returns an individual dog's name. 
4. Write a method, `.bark`, that `puts` "woof!" when called on an instance of Dog. 



<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-barking-dog' title='Barking Dog'>Barking Dog</a> on Learn.co and start learning to code for free.</p>
