# Ruby Inheritance Lab

## Objectives

1. Define classes that inherit from a shared parent, or super, class. 
2. Define methods unique to those classes. 


## Overview

In this lab, we'll be working with a school domain model. Our application has users that are either teachers or students. Teachers and students will share certain attributes and have certain behaviors that are unique to them. You'll be defining a `User` class that both students and teachers inherit from and you'll be writing methods within both the `Teacher` and `Student` class that are unique to that class. 

## Instructions

Run the test suite to get started. This is a test-driven lab. 

1. Define the `User` class such that a user can have a first and last name. You'll need both a setter and a getter for first and last name. 
2. We've given you a barebones `Teacher` class in `lib/teacher.rb`. Change the class definition so that the `Teacher` class inherits from the `User` class. Run the test suite and notice that you are passing some tests for the `Teacher` class, even without writing any code inside that class. That is because it will inherit the `#first_name` and `#last_name` methods from the `User` class you told it to inherit from. 
3. We've given you a class constant `KNOWLEDGE`, that points to an array of knowledge strings. Write a method, `#teach` that returns a random element from that array. You might want to look up the `Array#sample` method. 
4. We've given you a barebones `Student` class. Change the class definition so that it inherits from the `User` class. Run the test suite and notice that you are passing some tests for the `Student` class, even without writing any code inside that class. That is because it will inherit the `#first_name` and `#last_name` methods from the `User` class you told it to inherit from. 
5. Individual students should initialize with an instance variable, `@knowledge`, that points to an empty array. 
6. Define a method, `#learn`, that takes in a string and adds that string to the student's `@knowledge` array. 
7. Define a method, `#knowledge`, that returns that students knowledge array. 

### Bonus

We've set up an executable file for you in `bin/time_for_school`. Check out the code there and run the file with `ruby bin/time_for_school` in your terminal. Get a feel for how the code we wrote works and what methods are available to our student and teacher instances thanks to inheritance. 

Play around with it a bit more by trying out the following in this file:

* We have a new user, Jim, who is just here to audit a few classes. He is neither a teacher nor a student. Create a local variable, `jim`, and point it equal to an instance of the `User` class. Then, give `jim` a first and last name. What happens when you try to call `#learn` on `jim`?
* Continue to operate on our student, `steve`. Have `avi` teach him some more important knowledge. 
* Create a new student and have that student learn a few things from `avi` as well. 
* Then, `puts` out the existing knowledge of each student. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-inheritance-lab' title='Ruby Inheritance Lab'>Ruby Inheritance Lab</a> on Learn.co and start learning to code for free.</p>
