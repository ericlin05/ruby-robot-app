=======
ruby-robot-app
==============

A Ruby command line little app to show case the understanding of Ruby language

This ruby app was tested under Kubuntu with Ruby version 1.9.3p484 installed.

1. Requirement:

a. Need to install "test-unit" package for Ruby:

    sudo gem install test-unit

b. Use "rake" to run test cases

    sudo gem install rake

c. Need "mocha" for mocks and stubs in Ruby

    sudo gem install mocha

2. Running Tests:

To run the test cases, simply run from app's root directory

    rake

OR

    rake test

3. Running the application:

a. Run the app from the app's root directory without any options

    ruby -I . app.rb

   This will start the app using default settings

   i.   uses simple reporting (without the grid output)
   ii.  width is 5 units
   iii. height is 5 units

b. Pass "-h" to see parameter options

    ruby -I . app.rb -h

c. Pass extra options to customise the app

    ruby -I . app.rb -r fancy -x 20 -y 20

   -r - Report type, currently supports "simple" or "fancy", default to simple if not specified
   -x - The width of the table top, default to 5 if not specified or less than 5
   -y - The height of the table top, default to 5 if not specified or less than 5

d. I have also set up some sample test input to test this app based on PROBLEM.md file, 
   again, from the app's root directory

    cat sample/case* | ruby -I . app.rb -r fancy -x 10 -y 10

4. Quit the application:

    Simply type in "QUIT", "EXIT" commands or Ctrl + D to exit the program

