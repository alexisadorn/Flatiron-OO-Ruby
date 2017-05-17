# Object Oriented Email Parser

## Objectives

1. Practice defining a class and using an `attr_accessor` to create setter and getter methods
2. Use TDD to write working code

## Description

You will be writing an `EmailParser` class that gets initialized with a string of emails.

Your job is to parse those emails into a useful array using an instance method,
`parse`.

I should be able to do this:

```ruby
emails = "john@doe.com, person@somewhere.org"
parser = EmailParser.new(emails)

parser.parse
# => ["john@doe.com", "person@somewhere.org"]
```

You should be able to initialize with a list of emails either separated with spaces
*or* separated with commas. The `parse` method should, additionally, only return
unique emails.

## Instructions

This lab is test-driven, so run the test suite to get started and use the test output to get the program working. 

**Hints:**

* How will you control for parsing a list of emails that is *either* comma separated *or* separated by a white space. 
* Use an `attr_accessor` to set and get the list of emails


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-email-parser' title='Object Oriented Email Parser'>Object Oriented Email Parser</a> on Learn.co and start learning to code for free.</p>
