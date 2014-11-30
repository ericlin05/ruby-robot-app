
This ruby app was tested under KUbuntu with Ruby version 1.9.3p484 installed.

1. Requirement:

a. Need to install "test-unit" package for Ruby:

    sudo gem install test-unit

b. Use "rake" to run test cases

    sudo gem install rake

2. Running Tests:

To run the test cases, simply run from app's root directory

    rake

OR

    rake test

3. Running the application:

a. Run the app from the app's root directory without any options

    ruby -I . app.rb

b. You can also pass extra options to customise the app

    ruby -I . app.rb -r fancy -w 20 -h 20

-r - Report type, currently supports "simple" or "fancy", default to simple if not specified
-w - The width of the table top, default to 5 if not specified
-h - The height of the table top, default to 5 if not specified

c. I have also set up some sample test input to test this app, again, from the app's root directory

    cat sample/case* | ruby -I . app.rb -r fancy -w 10 -h 10
