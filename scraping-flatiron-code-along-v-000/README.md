# Object Oriented Scraping

## Objectives

1. Scrape a web page's HTML using Nokogiri.
2. Use scraped data to give attributes to Ruby objects.
3. Write an object oriented Scraper class.

## Overview

One of the most common use-cases for web scraping involves you, the programmer, scraping data that you will then use to instantiate your own Ruby objects. In this lab, we'll be scraping a static site that displays the course offerings of the Flatiron School. We'll be taking the scraped data to create our own `Course` objects. Each instance of the `Course` class will have a series of attributes. The values of each of these attributes will be scraped from the website.

We'll be creating two classes, `Scraper` and `Course`. The `Scraper` class will be responsible for using Nokogiri to scrape the relevant data. It will also be responsible for taking that data and using it to instantiate instances of the `Course` class.

## Code Along I: The `Course` Class

***Fork and clone this lab to get started!***

Before we build our `Scraper`, we'll build the `Course` class. We know that the purpose of our scrape is to get data to assign to the attributes of `Course` class instances.

Let's take a look at the site we'll be scraping in order to get a sense of what attributes we should give our `Course` class instances. Go ahead and open up [http://learn-co-curriculum.github.io/site-for-scraping/courses](http://learn-co-curriculum.github.io/site-for-scraping/courses).

Scroll down until you are looking at the list of course offerings:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%202.00.13%20PM.png)

We can see that each course has a title, a schedule (either Part- or Full-Time) and a description. This seems like a great place to start in terms of defining our own `Course` class objects.

Open up `lib/course.rb` and define your class:

```ruby
class Course
end
```

Now, let's run *just* the `Course` specs by typing `rspec spec/course_spec.rb` in the terminal. You should see the following test output:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%202.53.11%20PM.png)

Looks like we have some methods to define. Let's start with the instance method tests. The test output tells us that we need setters and getters for `title`, `schedule` and `description`. Let's make them `attr_accessors`

```ruby
class Course
  attr_accessor :title, :schedule, :description
end
```

Go ahead and run the test suite again. Now we should be passing all of our instance method tests! But not our class method tests...

Let's write the `.all` and `.reset_all` class methods. You should be familiar with the usage of the `.all` class method at this point––remember that every time an instance of the class is initialized, we should push it into the `@@all` class variable. Get these tests passing with the following code:

```ruby
class Course

  attr_accessor :title, :schedule, :description

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all
    @@all.clear
  end

end
```

Run the `Course` specs again and we should be passing all the tests. We're ready to write our `Scraper`!

## Code Along II: The `Scraper` Class

Start by running the `Scraper` specs with the `rspec spec/scraper_spec.rb` line in your terminal. You should see failing tests and describe a number of methods. Let's run through the desired behavior of each method:

##### `#get_page`

The `#get_page` instance method will be responsible for using Nokogiri and `open-uri` to grab the entire HTML document from the web page.

##### `#get_courses`

The `#get_courses` instance method will be responsible for using a CSS selector to grab all of the HTML elements that contain a course. In other words, the return value of this method should be a collection of Nokogiri XML elements, each of which describes a course offering. We're going to have to examine the page with the element inspector to find the CSS selector that contains the courses.

##### `#make_courses`

The `#make_courses` method will be responsible for actually instantiating `Course` objects and giving each course object the correct `title`, `schedule` and `description` attribute that we scraped from the page.

##### `#print_courses`

The `#print_courses` method we made for you! It calls on `.make_courses` and then iterates over all of the courses that gets created to `puts` out a list of course offerings. We gave you this freebie so that we can easily see how cool it is to scrape data and make real live Ruby objects with it.

Now that we have a basic concept of the methods we're expected to build, we're going to ignore them (surprise!). We've already discussed how tricky it is to scrape data from a web page. It is a very precise process and it takes *a lot* of playing around in Pry to find the right CSS selectors for the desired data. So, we're going to start by building our `#get_page` method. **As soon as we get the HTML document using Nokogiri, we will drop into our program using Pry and play around with CSS selectors until we find what we're looking for**. Once we have working code, we'll worry about organizing the appropriate code into the above-described methods.

### Getting the HTML Doc and Finding Our Selectors

Open up `lib/scraper.rb` and define the `.get_page` method:

```ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
      # more code coming soon!
  end

end
```

Notice that we are already requiring Nokogiri, open-uri and Pry at the top of the file. We are ready to use Nokogiri and open-uri to get our HTML. Add the following line to your `.get_page` method:

```ruby
doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
```

Then, we'll place a `binding.pry` on the next line. At the bottom of the file, outside of the class definition, we'll call `Scraper.new.get_page`. That way, we'll hit our binding and be able to play around with the HTML document in the terminal in order to find the CSS selectors we're looking for:


```ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page
      doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

      binding.pry
  end

end

Scraper.new.get_page
```

Once your file looks like the code above, run the file with `ruby lib/scraper.rb` in your terminal. Once you hit your binding, type the `doc` variable into the terminal and you should see the HTML document, retrieved for us by Nokogiri and open-uri. You should see something like this:

>Note: When you hit the pry, you may end up with a prompt that looks like this `:`. That just means there's a lot of text and you can scroll up and down using the arrow keys. If you need to escape this prompt so you can type in `doc`, then you simply have to press `q` or the `esc` key. 

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%204.25.06%20PM.png)

If you scroll down in your terminal, you should see more and more of the HTML document.

Okay, we're ready to find the CSS selector that will grab the course offering from the HTML document. How should we go about doing this? Should we guess? Should we manually read the entire HTML document, looking for the HTML elements that contain the course offerings? Nope. We're going to revisit the Flatiron website in the browser and use the developer tools of our browser to inspect the elements.

Click on [this link](http://learn-co-curriculum.github.io/site-for-scraping/courses) and once again scroll down to the section of the page that lists the course offerings. Right click on any course offering and select "inspect element". You should see something like this in your browser:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%204.38.49%20PM.png)

Let's take a closer look at the highlighted line in the element inspector:

```html
<article class="post same-height-left" style="height: 489px;">
```
Looks like the element that contains an individual course has a class of "post". Let's use this CSS selector of `.post` to try to grab *all* courses.

Go back to your terminal and execute the following line:

```bash
doc.css(".post")
```

You should see something like this:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%204.44.13%20PM.png)

Whoa! That's a lot of XML. But, if you take a closer look at the content, you'll see that these Nokogiri XML elements do describe the individual courses. You'll notice course titles and descriptions, among other pieces of information.

**Top-Tip:** You can scroll down and view more of a long document like this in Pry by using the down arrow key. To stop scrolling and free up the command line so that you are still in Pry but able to type in and execute lines of code, hit `q`.

Okay, now that we have a working line of code for grabbing all of the courses from the page, let's operate on those courses in order to find the title, schedule and description of each one.

### Finding CSS Selectors for The Desired Attributes

We know that a collection of Nokogiri XML elements functions like an array. So, it makes sense that we can iterate over the collection with an enumerator like `.each` or `.collect` in order to grab the title, schedule and description of each one. BUT, before we worry about iterating, lets grab *just one element* and try to identify the correct CSS selectors for title, schedule and description.

In your terminal, execute `doc.css(".post").first`. This will grab us just the first element from the collection. You should see something like this:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%204.52.21%20PM.png)

This describes *just one course offering*. If you look closely, you'll see it contains all the info we need. You can see the title, the schedule and the description. The easiest way to ID the correct CSS selector for extracting this information, however, is to revisit the web page and examine a course offering with our "inspect element" tool.


#### Scraping Course Title

Go back to the [site](http://learn-co-curriculum.github.io/site-for-scraping/courses) and open up the element inspector again. Click the symbol in the upper left of your console (it looks like an arrow cursor pointing into a box) to hover over the title of the first course offering. You should see a tag appear when you hover over the course title with this tool. The tag should say `h2 750.428 x 28px`.

We don't care about the height and width but we *do* care about the selector, `h2`.

Test the following code in your terminal:

```ruby
doc.css(".post").first.css("h2")
```

You should see the following returned to you:

```bash
[#<Nokogiri::XML::Element:0x3fc350c47c34 name="h2" children=[#<Nokogiri::XML::Text:0x3fc350c4793c "Web Development Immersive">]>]
```

We're so close! The course title is right there, inside the Nokogiri::XML:Text element. Let's grab it:

```ruby
doc.css(".post").first.css("h2").text
```

You should see the following return value:

```bash
"Web Development Immersive"
```

We did it! We found the code for grabbing an individual course's title. Let's do the same for schedule and description.

#### Scraping Course Schedule

Go back to the [site](http://learn-co-curriculum.github.io/site-for-scraping/courses) and open up the element inspector again. Use the magnifying glass symbol to hover over the schedule of the first course offering. You should see a tag appear when you hover over the schedule (the line that reads "Part-Time" or "Full-Time") that reads `em.date ...`

It looks like the schedule element has a class of "date". Let's use that CSS selector to grab the date of the first course.

In your terminal, execute:

```ruby
doc.css(".post").first.css(".date").text
```

You should see the following returned to you:

```bash
"Full-Time"
```

Great, now we have the code for grabbing an individual course's schedule. Let's get that description.

#### Scraping Course Description

Once again, use the magnifying glass to hover over the first course's description. You should see a tag appear with the following text: `p 750. blah blah some pixels`. Okay, it looks like we have our selector: the `p` tag.

Try out the following line in your console:

```ruby
doc.css(".post").first.css("p").text
```
You should see returned to you:

```bash
"An intensive, Ruby and Javascript course that teaches the skills necessary to start a career as a full-stack software developer."
```

We did it! We have the working code for grabbing:

* The page itself:
  * `doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))`
* The collection of course offerings:
  * `doc.css(".post")`
* The title of an individual course offering:
  * `doc.css(".post").first.css("h2").text`
* The schedule of an individual course offering:
  * `doc.css(".post").first.css(".date").text`
* The description of an individual course offering:
  * `doc.css(".post").first.css("p").text`


Now we're ready to use our code to create `Course` objects and give them attributes.

### Creating `Course` Objects with Scraped Attributes

Notice that the `scraper.rb` file includes this line near the top:

```ruby
require_relative './course.rb'
```

We are requiring our `Course` class file so that our `Scraper` can make new courses and give them attributes scraped from the web page.

We know how to grab an array-like collection of course elements from the page with the `doc.css(".post")` line. We also know what code will grab us the title, schedule and description of an individual member of that collection.

So, we can iterate over the collection, make a new `Course` instance for each course offering element we are iterating over, and assign that instance the scraped title, schedule and description, using the working code for those attributes that we already figured out.

In your `#get_page` method of the `Scraper` class, place the following code:

```ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page

    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    doc.css(".post").each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
```

For each iteration over the collection of Nokogiri XML elements returned to use by the `doc.css(".post")` line, we are making a new instance of the `Course` class and giving that instance the `title`, `schedule` and `description` extracted from the XML.

Place a `binding.pry` at the end of the method. Now, run the code in this file with `ruby lib/scraper.rb`. When you hit the binding, enter `Course.all` into your terminal and take a look at all the courses we made:

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-20%20at%205.29.51%20PM.png)

Wow! We have a collection of `Course` objects, each of which have attributes that we scraped from the website. We are such good programmers.

### Extracting Our Code into Methods

Okay, we have some great working code. But, it doesn't really *all* belong in the `#get_page` method. The `#get_page` method should be responsible for *just getting the page*. Let's do some refactoring and get our `Scraper` tests passing!

#### `#get_page`

This method should contain *only the code for getting the HTML document*. Place the following code in your `#get_page` method and *comment out the rest of that method*. We'll need to refer to that code to get our other tests passing.

```ruby
require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def get_page

    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))

    #doc.css(".post").each do |post|
      #course = Course.new
      #course.title = post.css("h2").text
      #course.schedule = post.css(".date").text
      #course.description = post.css("p").text
    #end
  end

end
```

Run your `Scraper` test suite with `rspec spec/scraper_spec.rb`. Your first test should be passing.

#### `#get_courses`

The `#get_courses` method should operate on the HTML page (which is the return value of the `.get_page` method) and return the collection of Nokogiri XML elements that describe each course. So, we'll call on our `.get_page` method inside the `.get_courses` method.

```ruby
def get_courses
  self.get_page.css(".post")
end
```

Run the test suite again and the second test should be passing.

#### `#make_courses`

The `#make_courses` method should operate on the collection of course offering Nokogiri XML elements that was returned by the `.get_courses` method. The `.make_courses` method should iterate over the collection and make a new instance of `Course` class for each one while assigning it the appropriate attributes:

```ruby
def make_courses
  self.get_courses.each do |post|
    course = Course.new
    course.title = post.css("h2").text
    course.schedule = post.css(".date").text
    course.description = post.css("p").text
  end
end
```

Run the test suite again and all of your tests should be passing!

Now, just for fun. Place the following line at the bottom of `lib/scraper.rb`

```ruby
Scraper.new.print_courses
```

Ta-da! We did it. Check out all of those awesome courses printed out to your terminal. If you're still having trouble getting your tests to pass, check out the final code below:

### Final Code: The `Scraper` Class

```ruby
require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end

Scraper.new.print_courses
```

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/scraping-flatiron-code-along' title='Object Oriented Scraping'>Object Oriented Scraping</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/scraping-flatiron-code-along'>Scraping Lab</a> on Learn.co and start learning to code for free.</p>
