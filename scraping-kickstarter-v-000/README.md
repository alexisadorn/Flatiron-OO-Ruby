# Scraping Kickstarter

## Objectives

1. Use Nokogiri to scrape an HTML document.
2. Use scraped data to build a nested data structure.

## Overview

In this lab, you'll be scraping a Kickstarter web page that lists projects requesting funding. The page you'll be scraping displays 20 previews of projects in the NYC area. Each project has a title, an image, a short description, a location and some funding details. Our goal is to collect this information for each project and build a hash for each project:

```ruby
:projects => {
  "My Great Project"  => {
    :image_link => "Image Link",
    :description => "Description",
    :location => "Location",
    :percent_funded => "Percent Funded"
  },
  "Another Great Project" => {
    :image_link => "Image Link",
    :description => "Description",
    :location => "Location",
    :percent_funded => "Percent Funded"
  }
}
```

These individual project hashes will be collected into a larger hash called `projects`.

## Fixtures

In the directory of this project you'll notice a folder called `fixtures`. Inside that folder you'll see a file, `kickstarter.html`. Open up that file and right click anywhere on the page. Select "open in browser" from the menu that appears.

Ta-da! We're looking at a web page. For the purposes of this lab, we won't be scraping a live web page. We'll be scraping this HTML page. We're doing this for two reasons. First, because web pages change. If we assign you a lab based on material that will change, things could get really confusing. Secondly, it is common to keep data that the test suite will use to test your program in a `fixtures` directory.

So, for this lab, we *don't need Open-Uri*. We're not opening a live web page.

## Instructions

### Setting Up Our Project

Since we'll be using that `kickstarter.html` file instead of an Open-URI request, we need to require only `nokogiri` at the top of the `kickstarter_scraper.rb` file

Next, let's set up some variables inside the method called `create_project_hash`:

```ruby
# This just opens a file and reads it into a variable
html = File.read('fixtures/kickstarter.html')

kickstarter = Nokogiri::HTML(html)
```

Notice that this is pretty similar to what we did to open HTML documents in the previous exercise in which we did use Open-URI.

### Selecting the Projects

The first thing we'll want to do is figure out what selector will allow us to grab each project as a whole. Open up `fixtures/kickstarter.html` by typing:

```bash
open fixtures/kickstarter.html
```

in the terminal, or by right clicking on the file and selecting "open in browser".

This should open the file in your web browser. Right click somewhere on the "Moby Dick" project and choose "Inspect Element". By moving your mouse up and down in the HTML in the inspector, you can see what each element represents on the page via some cool highlighting. By moving your mouse around, it quickly becomes clear that each project is contained in:

```html
<li class="project grid_4">...</li>
```

Since this Nokogiri object is just a bunch of nested nodes, and we know how to iterate through a nested data structure, we can use the Ruby we already know to iterate through each of these projects and do stuff with them.

Just to check our assumptions, let's add a `require 'pry'` at the top of our file, and add `binding.pry` after the last line. Call the `create_project_hash` method at the bottom of the file. Then type `ruby kickstarter_scraper.rb` into your terminal. This should drop us into Pry, so that we can play around.

In pry, type in:

```
kickstarter.css("li.project.grid_4").first
```

This will select the first `li` with the `project` and `grid_4` classes just so that we can make sure we've chosen our selectors correctly.

And we have! (If you don't see any output, or see an empty array, make sure you've typed everything exactly as it was typed here.)

Awesome! Let's add a comment to `kickstarter_scraper.rb` that reminds us of that selector:

```ruby
# projects: kickstarter.css("li.project.grid_4")
```

### Selecting the Title

Let's hop back into Pry and see if we can figure out how to get the title of that project.

In Pry, type:

```
project = _
```

This will assign that project to a variable, `project` so that we can play around with it.

**Reminder:** If you're looking at a big chunk of code in Pry that gets cut off at the bottom of your terminal window, you can scroll down with the down arrow key. You can escape the scrolling and go back to entering code in Pry by hitting "q".

**Top-Tip:** The `variable_name = _` syntax used in Pry will assign the `variable` name to the return value of whatever was executed above. For example:

```bash
$ pry > 1 + 1
  => 2
$ pry > two = _
$ pry > two
  => 2
```

Go back to your browser and use the element inspector to click around a bit and identify the selector for a project's title. A bit of inspection should reveal that the title of each project lives in an `h2` with a class of `bbcard_name`, inside a `strong` and then an `a` tag. Let's check that in pry:

```
project.css("h2.bbcard_name strong a").text
```

Since Nokogiri gives us a bunch of nested nodes that all respond to the same methods, we can just chain a `css` method right onto this `project`. Neat, huh?

Now that we have our `title` selector, let's add it into a comment in our `kickstarter_scraper.rb`.

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
```

### Selecting the Image Link

Back in Chrome, we can see in the inspector that there is a `div` with a class of `project-thumbnail`. Seems like a good place to look. Let's give it a try in Pry.

In Pry, type:

```
project.css("div.project-thumbnail a img").attribute("src").value
```

It worked! Now, let's continue to keep track of our working code in our project file:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
```

#### A Note on `.attribute`

An image tag in HTML is considered to have a source attribute. In the following example

`<img src="http://www.example.com/pic.jpg">`

the source attribute would be `"http://www.example.com/pic.jpg"`. You can use the `.attribute` method on a Nokogiri element to grab the value of that attribute.

### Selecting the Description

Are you starting to see a pattern here? We click around a bit in the Chrome web inspector, take a stab at a CSS selector in Pry, and then keep track of that selector in our project file. Let's grab the description now. In Pry:

```
project.css("p.bbcard_blurb").text
```

This should return the description of an individual project.

Let's add that to `kickstarter_scraper.rb`:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
```

### Selecting the Location

Do you think you can figure this one out on your own? Examine the web page and then play around in Pry. Try to find the right selector for an individual project's location.

### Selecting the Percent Funded

And last, but not least, let's try and grab the percent funded as well! Looking in Chrome, it seems that this one is just a bit trickier, but only because it's more nested than the other ones. In Pry, type:

```
project.css("ul.project-stats li.first.funded strong").text
```

That does it! To make it useful for later on if, say, we wanted to do some math, let's also tag on a `.gsub("%", "").to_i` to remove the percent sign and convert it into an integer.

Our final list of comments in our `kickstarter_scraper.rb` file, then (including the location that you should have figured out on your own), is:

```ruby
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
```

### Let's Scrape!

Now, it's just a matter of putting together the data we can grab with Nokogiri with our knowledge of data iteration in Ruby.

First, let's set up a loop to iterate through the projects (and also an empty `projects` hash, which we will fill up with scraped data):

```ruby
# file: kickstarter_scraper.rb

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  # Iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    projects[project] = {}
  end

  # return the projects hash
  projects
end
```

Ok, so that won't work, actually. That's going to make some really wacky key which is a huge Nokogiri object. So, let's change our data structure slightly and make it so that each project title is a key, and the value is another hash with each of our other data points as keys. Sound good?

```ruby
# file: kickstarter_scraper.rb

...

def create_project_hash
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {}
  end

  # return the projects hash
  projects
end
```

That's better. You'll notice that we're converting the title into a symbol using the `to_sym` method. Remember that symbols make better hash keys than strings.

Finally, it's just a matter of grabbing each of the data points using the selectors we've already figured out, and adding them to each project's hash. So, our complete code will look something like this:

```ruby
# file: kickstarter_scraper.rb

require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  # return the projects hash
  projects
end
```

We did it! Run the test suite and you should see that all of the tests are passing.


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/scraping-kickstarter' title='Scraping Kickstarter'>Scraping Kickstarter</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/scraping-kickstarter'>Kickstarter Scraping Lab</a> on Learn.co and start learning to code for free.</p>
