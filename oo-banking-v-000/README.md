# Object Oriented Banking

## Objective

1. Use TDD to code two classes that interact with each other. 

## Description

We're going to build a `BankAccount` class where one instance of the class can transfer money to another instance through a `Transfer` class. The `Transfer` class acts as a space for a transaction between two instances of the bank account class. Think of it this way: you can't just transfer money to another account without the bank running checks first. `Transfer` instances will do all of this, as well as check the validity of the accounts before the transaction occurs. `Transfer` instances should be able to reject a transfer if the accounts aren't valid or if the sender doesn't have the money.

Transfers start out in a "pending" status. They can be executed and go to a "complete" state. They can also go to a "rejected" status. A completed transfer can also be reversed and go into a "reversed" status.

## Instructions

Pass the tests. They are deliberatively vague; your design is up to you! Read the test output and test files very carefully to get through this one. 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/oo-banking' title='Object Oriented Banking'>Object Oriented Banking</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/oo-banking'>OO Banking</a> on Learn.co and start learning to code for free.</p>
