# Object Oriented Kickstarter

## Objectives

1. Build classes that produce objects that relate to one another. 

## Description

In this lab, we are going to be creating a very, very simple version of Kickstarter. We'll have Projects and Backers (and no concept of money at all), and they will need to interact with one another in a realistic way.

We want our interface to work something like this:

```ruby
bob = Backer.new("Bob")
awesome_project = Project.new("This is an Awesome Project")

bob.back_project(awesome_project)

bob.backed_projects
# => #<Project:0x000001018683d0 @title="This is an Awesome Project"...>

awesome_project.backers
# => #<Backer:0x000001018b9370 @name="Bob"...>
```

## Instructions

The specs have been set to run in default order, and are written in such a way that tests for the Backer and Project classes are mixed in with one another. This is not how you'd normally see specs for multiple objects. For the purposes of this lab, though, following the specs, in order, will eventually lead you to the correct relationships between your classes.

A few hints to get you started: 

* When a `Backer` instance is initialized, it should be initialized with a `@backed_projects` variable set to an empty array. Instances of the `Backer` class should have an `attr_accessor` for backed projects so that projects can be added to a backer's list and so that the backer can report on the projects they back. 
* When a `Project` instance is initialized, it should be initialized with a `@backers` variable set to an empty array. Instances of the `Project` class should have an `attr_accessor` for backers so that projects can add backers to their list of backers and report on the backers who support them. 
* When a backer has added a project to its list of backed projects, that project should *also add the backer to its list of backers*. Refer back to the Code Along about Collaborating Objects.


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-kickstarter' title='Object Oriented Kickstarter'>Object Oriented Kickstarter</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/oo-kickstarter'>OO Kickstarter</a> on Learn.co and start learning to code for free.</p>
