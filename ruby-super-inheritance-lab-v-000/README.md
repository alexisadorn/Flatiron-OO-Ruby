# Ruby Super Inheritance Lab 

## Objectives

1. Define two classes, one of which inherits from another. 
2. Define methods in the child class that use the `super` keyword to inherit from and augment methods in the parent class. 

## Instructions

In this lab, you'll be coding a `Student` class, which will be the parent class, and a `ChattyStudent` class, which will inherit from student. `ChattyStudent` *is* a student, so should have all of the behaviors and characteristics of a student. But, `ChattyStudent` is *very chatty*. So, he or she will elaborate on any phrases that are inherited from `Student`. 

* Write a method in the `Student` class, `#hello`, that `puts` out the phrase: `"Hey there! I'm so excited to learn stuff."`
* Write a method in the `Student` class, `raise_hand`, that `puts` out the phrase: `"Pick me!"`
* Write a method in the `ChattyStudent` class, `#hello`, that uses the `super` keyword to inherit the behavior of the `#hello` method from the parent, `Student`, class. Then, augment that method to also `puts` out the very chatty phrase: `"How are you doing today? I'm okay, but I'm kind of tired. Did you watch The Walking Dead last night? You didn't?! Oh man, it was so crazy! What, you don't want any spoilers? Okay well let me just tell you who died..."`
* Write a method in the `ChattyStudent` class, `raise_hand`, that uses the `super` keyword ten times so that the method will `puts` out `"Pick me!"` ten times. **It is possible to simply call `super` multiple times in a method**. 
<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-super-inheritance-lab' title='Ruby Super Inheritance Lab'>Ruby Super Inheritance Lab</a> on Learn.co and start learning to code for free.</p>
