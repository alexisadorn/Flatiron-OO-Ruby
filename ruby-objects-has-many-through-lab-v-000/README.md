
# Ruby Object Relations: Has-Many-Through Lab

## Objectives

1. Write classes that are related to each other via the "has-many-through" relationship.
2. Write methods that use the "has-many-through" relationship to deliver information on related objects. 

## Overview

In this lab, we'll be dealing with two sets of three classes. 

We have a `Song`, `Artist` and `Genre` class. Songs belong to an artist and belong to a genre. A genre has many songs and an artist has many songs. An artist has many genres through its songs and a genre has many artists through its songs. 

We also have an `Appointment`, `Doctor` and `Patient` class. Appointments belong to a patient and to a doctor. A doctor has many appointments and a patient has many appointments. A doctor has many patients through its appointments and a patient has many doctor's through its appointments. 

## Instructions

Start with the `Artist`/`Song`/`Genre` domain. 

**The `Artist` model:**

* An artist is initialized with a name and an empty `@songs` array. 
* The `Artist` class needs an instance method, `#add_song`, that takes in an argument of a song and adds that song to the artist's collection of songs. The `#add_song` method should also tell the song that it belongs to that artist. 
* The `Artist` class needs an instance method, `#songs`, that returns the `@songs` array. 
* The `Artist` class needs an instance method, `#genres` that iterates over that artist's songs and collects the genre of each song. 

**The `Song` model:**

* A song should be initialized with a name and a genre. The initialize method should associate that song to the genre passed in as an argument. How can you associate a song to a genre? A song needs a "genre" attribute. Try creating an `attr_accessor` for `genre`. Genres also need to know about songs. You'll need to create a `Genre#add_song` method. Let's come back to this in a minute.  


**The `Genre` model:**

* A genre should be initialized with a name and an empty `@songs` array. 
* The `Genre` class needs an instance method, `#add_song`, that takes in an argument of a song and adds that song to the genre's collection of songs. Now you can use the `Genre#add_song` method in the `Song` class' initialize method to tell the genre that it owns the given song. 
* The `Genre` class needs an instance method, `#songs`, that returns the `@songs` array. 
* The `Genre` class needs an instance method, `#artists`, that iterates over the genre's collection of songs and collects the artist that owns each song. 

Now let's move on to our `Doctor`/`Appointment`/`Patient` domain model. 

**The `Doctor` model:**

* A doctor should be initialized with a name and an empty `@appointments` array. 
* The `Doctor` class needs an instance method, `#add_appointment`, that takes in an instance of the `Appointment` class and adds that appointment to the doctor's `@appointments` array. The method should also tell that appointment that it belongs to that doctor. 
* The `Doctor` class needs an instance method, `#appointments`, that returns the `@appointments` array. 
* The `Doctor` class needs an instance method, `#patients`, that iterates over that doctor's appointments and collects the patient that belongs to each appointment. 

**The `Appointment` model:**

* An appointment should be initialized with a date (as a string, like `"Monday, August 1st"`), and a doctor. The `#initialize` method should tell the new appointment that it belongs to the doctor passed in as an argument and tell the doctor that it now has this appointment in its collection of appointments. Use the `Doctor#add_appointment` method here. 

**The `Patient` model:**

* A patient is instantiated with a name and an empty `@appointments` array. 
* The `Patient` class needs an instance method, `#add_appointment`, that takes in an argument of an appointment and adds that appointment to the `@appointments` array. This method should also tell the appointment that it belongs to this patient. 
* The `Patient` class needs an instance method, `#appointments`, that returns the content of the `@appointments` array. 
* The `Patient` class needs an instance method, `#doctors`, that iterates over that patient's appointments and collects the doctor that belongs to each appointment. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/ruby-objects-has-many-through-lab' title='Ruby Object Relations: Has-Many-Through Lab'>Ruby Object Relations: Has-Many-Through Lab</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/ruby-objects-has-many-through-lab'>Has Many Objects Through Lab</a> on Learn.co and start learning to code for free.</p>
