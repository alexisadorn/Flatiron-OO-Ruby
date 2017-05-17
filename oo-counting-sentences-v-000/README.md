# Counting Sentences

## Objectives

1. Practice defining instance methods on a class.
2. Practice defining instance methods that use the self keyword to operate on the object on which the method is being called.
2. Learn about monkey patching.

## Overview

In this lab, you'll be adding a few instance methods to Ruby's `String` class. We generally want to avoid altering built-in classes (especially if we are working with other people), but in this case, we're not overwriting any methods, and it's a good exercise in OO programming. The practice of adding methods to or altering Ruby's built in classes is called monkey patching. 

The `String` class is just like any other class that we might define, such as a `Dog` class or a `Person` class. The `String` class, however, is native to, or included in, Ruby. So, we can add or change methods in the `String` class just like we would in any of the classes that we define ourselves. 

### Monkey Patching

Monkey patching is the practice of adding methods to or altering Ruby's core classes. Monkey patching is dangerous! What if, for example, you decide to monkey patch Ruby's String class to produce a quick-fix that shortens a certain section of code in your program. Then, months later, you run into major bugs as a result, or some of your collaborators don't know about your monkey patch and develop bugs of their own that they don't know the origin of? For reasons like these, monkey patching should be considered very, very carefully. We're going to do it today, just for fun, but you do want to avoid doing it when working on your own programs. 

## Instructions

You'll be coding your solution in `lib/count_sentences.rb`. 

### The `#sentence?` Method

Define this instance method to return `true` if the string you are calling it on ends in a period and false if it does not. 

You will need to use the `self` keyword in the body of this method to refer to the string on which the method is being called. You can use the `#end_with?` method to determine what the final character in a string is. 

For example:

```ruby
"HI!".end_with?("!")
  => true
```

Call the `end_with?` method on `self` inside of your `#sentence?` method. 

### The `#question?` Method

This instance method should use the `self` keyword to refer to the string on which it is being called. This method should return true if a string ends with a question mark and false if it does not. 

### The `exclamation?` Method

This instance method should use the `self` keyword to refer to the string on which it is being called. This method should return true if a string ends with an exclamation mark and false if it does not. 

### The `#count_sentences` Method

What we'd like to be able to do is call a `count_sentences` method on a string, and get back a, well, count of sentences in that string. In other words:

```ruby
"This is a string! It has three sentences. Right?".count_sentences
# => 3
```

Your `#count_sentences` method should use the `self` keyword to refer to the string on which it is called. 

Think about the steps you need to go through to enact the desired behavior:

* [`split`](http://ruby-doc.org/core-2.2.0/String.html#method-i-split) the string on any and all periods, question marks and exclamation marks. 
* [`count`](http://ruby-doc.org/core-2.2.0/Array.html#method-i-count) the number of elements that results from that `split`. 
* Remember to consider edge cases such as the following sentence: `"This, well, is a sentence. This is too!! And so is this, I think? Woo..."`. What would happen if we split this sentence on the punctuation characters? We would end up with an array that contains empty strings as well as strings containing sentences. How would you eliminate empty strings from an array? We recommend placing `require 'pry'` on the top of the file and placing a `binding.pry` inside of the `#count_sentences` method to help you get this test passing. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-counting-sentences' title='Counting Sentences'>Counting Sentences</a> on Learn.co and start learning to code for free.</p>

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-counting-sentences'>OO Counting Sentences</a> on Learn.co and start learning to code for free.</p>
