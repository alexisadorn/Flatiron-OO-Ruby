# Object Oriented Student Scraper

## Objectives

1. Build two classes, a class that is responsible for scraping data from a web page and a class that uses that data to instantiate new objects.
3. Understand the contents of a third class that is responsible for the command line interface.
2. Use metaprogramming to instantiate new instances of a class and add attributes to instances of a class.

## Overview

In this lab, you'll be scraping your Learn.co student website. You'll use the index page to grab a list of current students and instantiate a series of `Student` objects. You'll scrape the individual profile pages of each student to add attributes to each individual student.

We've given you a third class, `CommandLineInterface` that is responsible for generating students using both the `Student` and `Scraper` classes. As you go through this lab, take some time to read through the code in the `CommandLineInterface` class. Try to understand how it works and how it uses the code in our other classes to actually create, add attributes, and display students to the user via the command line interface.

We've also given you an executable file in `bin/run` that you can execute once you get your tests passing to see your code in action!

## Before You Begin

For this project, we'll be scraping data from your student site at [students.learn.co](http://students.learn.co/). Sort of. We can't really give you a project with a full test suite and base those tests on a real live website on the real live internet. Why? Because websites change! They get new styling, new information, or they break because someone did something wrong. It happens! So, any tests we write would be based on the website at a given point in time. The code you write to pass those tests would assume that you are scraping a website that may have since changed. Your scraper would pass tests but fail to actually scrape the web page if you tried to run your code by sending a real web request to the real website. That would be terrible! Then you couldn't see your code in action or view the page you were writing code to scrape. Just awful.

Don't worry! We've very cleverly solved this problem for the purposes of this project. We've stored a copy of your student site *inside a subdirectory in this project*. The copy is being maintained only for the purposes of this project, so we don't have to worry about things like the styling changing or the code breaking and effecting our scraper code.

To locally view the stored web page, simply type the following into your terminal: `open fixtures/student-site/index.html`

**Important if you're using the Learn IDE:** If you're using the Learn IDE you'll have to run a server to view the site. You can do this by typing `httpserver &` to run the server in the background (make sure you know how to switch this job back to the foreground so you can close the server later with `ctrl + c`). Enter the IP address this command outputs into your web browser.  Then navigate to the fixtures folder, and then the student-site folder and the page should come up! For more information on background jobs in bash, take a look at this readme: https://github.com/learn-co-curriculum/bash-background-jobs/

## Instructions

Run `bundle install` first.

### The `Scraper` Class

Let's start with the `Scraper` class in `lib/scraper.rb`. In this class you are responsible for defining two methods. The `#scrape_index_page` method is responsible for scraping the index page that lists all of the students and the `#scrape_profile_page` method is responsible for scraping an individual student's profile page to get further information about that student.

#### The `#scrape_index_page` Method

This is a class method that should take in an argument of the URL of the index page. It should use nokogiri and Open-URI to access that page. The return value of this method should be an array of hashes in which each hash represents a single student. The keys of the individual student hashes should be `:name`, `:location` and `:profile_url`.

Here's a look at the desired behavior:

```ruby
Scraper.scrape_index_page(index_url)
# => [
        {:name => "Abby Smith", :location => "Brooklyn, NY", :profile_url => "./fixtures/student-site/students/abby-smith.html"},
        {:name => "Joe Jones", :location => "Paris, France", :profile_url => "./fixtures/student-site/students/joe-jonas.html"},
        {:name => "Carlos Rodriguez", :location => "New York, NY", :profile_url => "./fixtures/student-site/students/carlos-rodriguez.html"},
        {:name => "Lorenzo Oro", :location => "Los Angeles, CA", :profile_url => "./fixtures/student-site/students/lorenzo-oro.html"},
        {:name => "Marisa Royer", :location => "Tampa, FL", :profile_url => "./fixtures/student-site/students/marisa-royer.html"}
      ]
```

**Top-Tip:** Remember to use the element inspector in your browser's developer tools to examine each element whose value you are trying to scrape. Also remember to use `binding.pry` and experiment with different element selectors in your terminal. It takes a lot of trial and error to find the correct selectors for the desired element.

#### The `#scrape_profile_page` Method

This is a class method that should take in an argument of a student's profile URL. It should use nokogiri and Open-URI to access that page. The return value of this method should be a hash in which the key/value pairs describe an individual student. Some students don't have a twitter or some other social link. Be sure to be able to handle that. Here is what the hash should look like:

```ruby
Scraper.scrape_profile_page(profile_url)
# => {:twitter=>"http://twitter.com/flatironschool",
      :linkedin=>"https://www.linkedin.com/in/flatironschool",
      :github=>"https://github.com/learn-co,
      :blog=>"http://flatironschool.com",
      :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
      :bio=> "I'm a school"
     }
```

The only attributes you need to scrape from a student's profile page are the ones listed above: twitter url, linkedin url, github url, blog url, profile quote, and bio. The hash you build using those attributes should be formatted like the one in the example above.

**Why class methods?**

Why are our scraping methods being defined as class methods? Well, we don't need to store any information about the `Scraper` once it has completed the job of scraping. We simply need to scrape some information and pass that information along to our `Student` class. So, we don't need to produce instances of `Scraper` that maintain their own attributes.

### The `Student` Class

We've already given you the `attr_accessors` that you are required to have for each individual student.

The student class will use the information returned by the above methods from our `Scraper` class in order to create students and add attributes to individual students. However, the `Student` class shouldn't know about the `Scraper` class. This means that the `Student` class shouldn't directly interact with the `Scraper` class––it shouldn't call on the `Scraper` class in any of its methods or take in the `Scraper` class itself as an argument. Why is this? We want our program to be as flexible as possible. We can imagine any number of applications that use a `Student` model. So we don't want our `Student` model to be dependent on *how* it gets information regarding the students it creates. It should simply be ready to take in that information, regardless of its source (be it scraping, a .csv file, or a form on a website).

#### The `#create_from_collection(students_array)`

This class method should take in an array of hashes. In fact, we will call `Student.create_from_collection` with the return value of the `Scraper.scrape_index_page` method as the argument. The `#create_from_collection` method should iterate over the array of hashes and create a new individual student using each hash. This brings us to the `#initialize` method on our `Student` class.

##### The `#initialize` Method

The `#initialize` method should take in an argument of a hash and use metaprogramming to assign the newly created student attributes and values in accordance with the key/value pairs of the hash. Use the `#send` method to acheive this. This method should also add the newly created student to the `Student` class' `@@all` array of all students. You'll need to create this class variable and set it equal to an empty array at the top of your class. Push `self` into the array at the end of the `#initialize` method.

#### The `#add_student_attributes` Method

This instance method should take in a hash whose key/value pairs describe additional attributes of an individual student. In fact, we will be calling `student.add_student_attributes` with the return value of the `Scraper.scrape_profile_page` method as the argument.

The `#add_student_attributes` method should iterate over the given hash and use metaprogramming to dynamically assign the student attributes and values in accordance with the key/value pairs of the hash. Use the `#send` method to achieve this.

**Important:** The return value of this method should be the student itself. Use the `self` keyword.

#### The `.all` Method

This class method should return the contents of the `@@all` array.

## Our Code in Action

Now that you have all your tests passing, you can run our executable file, which relies on our `CommandLineInterface` class.

We've provided you with all of the code in the `CommandLineInterface` class. Take a few minutes to read through this class and gain a strong understanding of how it uses the code you wrote in your Scraper and Student classes to make a request to the local files and scrape the students.

Now run the executable file with `ruby bin/run`. You should see all of the students you scraped and instantiated `puts`-ed out to the terminal. Great job!

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-student-scraper' title='Object Oriented Student Scraper'>Object Oriented Student Scraper</a> on Learn.co and start learning to code for free.</p>
