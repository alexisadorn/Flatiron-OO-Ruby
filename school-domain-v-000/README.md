# Domain Model for a School

## Objectives

1. Define the concept of a domain model. 
2. Create your own domain model. 
3. Write instance methods that manipulate nested data structures. 

## What is a Domain Model?

A domain model is a representation of real-world concepts in software. The concept of domain modeling is key in object orientation. In object orientation, we think of our classes as templates for objects. The instances of our classes are thought of as objects. For example, a Person class produces people objects that have attributes and behaviors, as described and enacted by instance methods. 

Let's think of an example on a slightly larger scale. Let's say we are writing an application that will be used by a major automobile manufacturer to help manage their plants. In this case, we need a program that represents not just individual cars, but the entire car factory. In this (simplified) example, you could write an `AutoPlant` class that produces individual cars and has instance and class methods that handle things like `take_inventory` or `paint_cars`. Such a program not only represents a single object or concept but an entire environment––that of the auto factory. Consequently, this program could be understood as a domain model. It takes the world of the auto factory, and maps the constituents of that world into your program. 

As we begin to write more and more advanced programs, you'll see that to really accurately model a domain, we'll need to build a program that contains more than one class. For now, however, we'll keep it simple.

In this assignment you'll be writing a simple domain model that represents a school. 
## Instructions

This lab is primarily test-driven. Use the test output, along with the guidelines below. 

### Part 1. 

Create a class, School, in the `lib` directory that can be initialized with a name. The School class would be referred to as a "model" in the domain model context. 
```ruby
school = School.new("Bayside High School")
```

### Part 2. 

A school should have a roster. The roster should be an empty hash upon initialization but will be built out to contain keys of grade levels. The value of each key will be an array of student names. 

```ruby
school.roster
# => {}
```
### Part 3.

You should be able to add a student to the school by calling the `add_student` method and giving it an argument of the student's name and their grade.

```ruby
school.add_student("Zach Morris", 9)
school.roster
# => {9 => ["Zach Morris"]}
``` 

**Hint:** If the roster hash starts off as being empty, how will you add key/value pairs to it, where the value is an array? Let's take a look at an example: 

```ruby
hash = {}
```

We start off with an empty hash above. Our desired result is a hash with a key that points to a value of an array. That array should contain a series of items. What happens if we try to create the key/value pair we want *and* add an item to the value array, all at the same time?

```ruby
hash["new_key"] << "new_value_for_value_array"
 => NoMethodError: undefined method `<<' for nil:NilClass
```

We get an error! We can't push an item into an array that is the value of a key that doesn't exist yet! So, we *first* need to create the new key and point it to an empty array. *Then* we can push the new value into that array. 

```ruby
hash[new_key] = []
hash[new_key] << new_value_for_value_array

hash
 => {"new_key"=>["new_value_for_value_array"]} 
```

Ta-da! When we first create the key and point it to a value of an empty array, we are able to then successfully add items to that array. 

**Hint:** Now that we've thought about how to build up our hash, let's talk about how to add successive students to each grade. Let's say that we're adding the student `"AC Slater"` to grade `9`. If the `roster` already has a key of grade `9`, we'll be able to push AC Slater into the array that the grade `9` key points to. Otherwise, we'll need to first create the key of grade `9` and point it to an empty array. However, if we're in the scenario in which the grade `9` key already exists, we will erase its current contents by creating a key of `9` and setting it equal to an empty array! You'll need to understand this in order to get the tests passing. 

Here's an example of the desired behavior:

```ruby
school.add_student("AC Slater", 9)
school.add_student("Kelly Kapowski", 10)
school.add_student("Screech", 11)
school.roster
# => {9 => ["Zach Morris", "AC Slater"], 10 => ["Kelly Kapowski"], 11 => ["Screech"]}
```

### Part 4. 

A method, `grade`, should take in an argument of a grade and return all of the students in that grade:

```ruby
school.grade(9)
# => ["Zach Morris", "AC Slater"]
```

### Part 5.
 
You should be able to get a sorted list of all the students where the strings in the student arrays are sorted alphabetically. For instance:

```ruby
school.sort
# => {9 => ["AC Slater", "Zach Morris"], 10 => ["Aardvark", "Kelly Kapowski"], 11 => ["Screech", "Xavier"]}
```

Note that since hashes are unordered by nature, the order of the keys does not matter here, just the order of the student's names within each array.

## Resources
* [StackOverflow](http://stackoverflow.com/) - [What does ||= (or equals) mean in Ruby?](http://stackoverflow.com/questions/995593/what-does-or-equals-mean-in-ruby)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/school-domain' title='Domain Model for a School'>Domain Model for a School</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/school-domain'>OO School Domain</a> on Learn.co and start learning to code for free.</p>
