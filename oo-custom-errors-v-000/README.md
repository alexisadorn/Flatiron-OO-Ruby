# Code Along: Custom Error Handling

## Objectives

1. Create and raise custom error messages in Ruby. 

## Introduction

We already know that Ruby has a hierarchy of error, or `Exception`, classes, all of which inherit from the Exception class. We've become familiar with these error types: 

* `NoMethodError`
* `ArgumentError`
* `SyntaxError`

And these are just a few! Let's say, however, that we are working on a web application in which users can sign in and post pictures to Instagram. But wait! Instagram has been hacked and their entire site is currently down! Since our app relies on sending data to and getting a response from the Instagram site, our app will break and our users won't know why. They'll only know that our app is broken and they may even stop using it entirely. Not good. Lucky for us, we can use custom error messages and custom error handling to save the day! 

By defining custom error messages and handling, we can show our users a specific error message in the event of a disaster like the one above. By handling these custom errors in a particular way, we can soothe our users by redirecting them somewhere useful, showing them some kind of clear and apologetic notice, or showing them a fun, relaxing picture of a cat. 

We'll learn more about these common use cases for handling errors in web applications later on in this course. In this reading and the following lab, we'll practice building simple custom errors. 

**This is a code along.** There are no tests to pass, but you must manually fork and clone [this repo](https://github.com/learn-co-students/oo-custom-errors-v-000) in order to code along!

## Before We Begin, a Note on Inheritance

If one class inherits from another, that means it takes on all of the methods and behaviors of the class from which it inherits. In the below example, the `Child` class inherits from the `Parent` class. Consequently, all instances of `Child` have, not only the behaviors and methods that you might define in the `Child` class itself, but all of the methods and behaviors defined in the `Parent` class. 

```ruby
class Child < Parent
end
```

## Building a Custom Error

To build a custom error, we define an error class that inherits from the Exception class. Which class your custom error inherits from will likely depend on the situation in which you want to raise it. However, it is usually a pretty safe bet to inherit your custom error class from the StandardError class. For more info on error class hierarchies, you can review this chart of error class inheritance: 

```bash
Exception
 NoMemoryError
 ScriptError
   LoadError
   NotImplementedError
   SyntaxError
 SignalException
   Interrupt
 StandardError
   ArgumentError
   IOError
     EOFError
   IndexError
   LocalJumpError
   NameError
     NoMethodError
   RangeError
     FloatDomainError
   RegexpError
   RuntimeError
   SecurityError
   SystemCallError
   SystemStackError
   ThreadError
   TypeError
   ZeroDivisionError
 SystemExit
 fatal
```

### Defining our Error Class

Let's look at the example of our Person class and its `get_married` method. In `custom_errors.rb`, we have the following code:

```ruby
class Person
  attr_accessor :name, :partner
  
  def initialize(name)
    @name = name
  end
  
  def get_married(person)
    self.partner = person
    person.partner = self
  end
  
  
end
``` 
As it currently stands, we would receive a NoMethodError if we try to pass get_married an argument of anything that *is not* an instance of the Person class. 

For example, at the bottom of our `custom_errors.rb` file, we're trying to tell Beyonce to `get_married` to `"Jay-Z"`. The problem is that `"Jay-Z"` is a string, *not* an instance of the Person class. 

Run the code in the `custom_errors.rb` file with the `ruby custom_errors.rb` command. You should see the following output: 

```bash
custom_errors.rb:10:in `get_married': undefined method `partner=' for "Jay-Z":String (NoMethodError)
```

That's pretty informative as errors go. However, we're here to learn about raising our very own custom errors. So, for the sake of this example, let's say we are not satisfied with this error. Let's make our own!

### Step 1: Defining the Custom Error Class

Let's define a custom error class, `PartnerError` that inherits from `StandardError`:

```ruby
class PartnerError < StandardError
end
```

Okay, we have the code for our custom error class right here, but where does it belong in our application? We have a couple of options. We can simply place the above code *inside* of the Person class. We could define it outside of our Person class. Or, we can create a module and include that module inside the Person class. For now, we're going to include our custom error class inside of our Person class. 

**Add the following to your Person class:** 


```ruby
class Person 
  attr_accessor :name, :partner
  
  ...
  
  def get_married(person)
    self.partner = person
    person.partner = self
  end
  
  class PartnerError < StandardError
  end
end
```

Now we're ready to use our custom error inside our `get_married` method.

### Step 2: Raising Our Custom Error

We need to tell our program to raise our brand new `PartnerError` when the argument passed into the `get_married` method is *not* an instance of the Person class. We can do that with the `raise` keyword. Place the following code in your `get_married` method: 

```ruby
class Person
  attr_accessor :partner, :name

  def initialize(name)
    @name = name
  end

  def get_married(person)
    self.partner = person
    if person.class != Person 
      raise PartnerError 
    else
      person.partner = self
    end
  end

  class PartnerError < StandardError
  end
end
```

Now, go ahead and run the file again. This time you should see the following in your terminal:

```bash
custom_errors.rb:11:in `get_married': Person::PartnerError (Person::PartnerError)
```

We did it! We raised our very own custom error. However, our program is still broken. Notice that the `puts beyonce.name` line at the bottom of our file *won't run* because it follows the `get_married` method call, and we called that method in such a way as to raise an error. If only there was a way for us to *rescue* our program when such an error is raised and allow it to keep running...

## Custom Error Handling 

We can achieve the above goal via something called **rescuing**. Before we look at how to rescue the errors we raise and allow our program to continue to run, let's think about the desired behavior of our rescue. 

### Step 1: Writing a Custom Error Message

Of course we want our program to continue running after we raise the error. It would also be nice to output a custom error message when the error is raised. Let's add a message to our PartnerError class:

```ruby
class PartnerError < StandardError
  def message 
    "you must give the get_married method an argument of an instance of the person class!"
  end
end
```

Now we have a nice, informative, custom error message that will make it really clear to our users what went wrong if they encounter this error. Now we're ready to implement our rescue.

### Step 2: Implementing the Rescue

The basic pattern of error rescuing is as follows:

```ruby
begin 
  raise YourCustomError
rescue YourCustomError
end
```

Let's implement this code in our `get_married` method: 

```ruby
def get_married(person)
    self.partner = person
    if person.class != Person
      begin
        raise PartnerError
      rescue PartnerError => error
          puts error.message
      end
    else
      person.partner = self
    end
end
```

If the object passed into the method as an argument *is not* an instance of the Person class, we will `begin` our error handling. First, we `raise` our `PartnerError`, then we `rescue` our `PartnerError`. The `rescue` method creates an instance of the PartnerError class and puts out the result of calling `message` on that instance. 

At this point, the code in `custom_errors.rb` should look like this: 

```ruby
class Person
  attr_accessor :partner, :name

  def initialize(name)
    @name = name
  end

  def get_married(person)
    self.partner = person
    if person.class != Person
      begin
        raise PartnerError
      rescue PartnerError => error
          puts error.message
      end
    else
      person.partner = self
    end
  end

  class PartnerError < StandardError
    def message 
      "you must give the get_married method an argument of an instance of the person class!"
    end
  end
end

beyonce = Person.new("Beyonce")
beyonce.get_married("Jay-Z")
puts beyonce.name
```

Now, run the file one more time and you'll see that not only is our custom error message put out, but the program continues to run and will execute the `puts beyonce.name` line. 

```bash
you must give the get_married method an argument of an instance of the person class!
Beyonce
```

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-custom-errors' title='Custom Errors'>Custom Errors</a> on Learn.co and start learning to code for free.</p>
