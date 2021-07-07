# T&C Generator App

## App setup 
### Required Ruby and Bundler versions
#### Ruby
This app has been developed and tested on Ruby version `3.0.1`.
But you can use any Ruby version `> 2.5`.

Use `rbenv` or `rvm` to install it. I prefer `rbenv` over `rvm`. You can check out, on how to install [rbenv](https://github.com/rbenv/rbenv).

#### Bundler
You must have bundler version `2.2.15`. Run the below command to install it.
```
$ gem install bundler:2.2.15
$ bundle install
```
Now the app is install and ready to run on your machine.

## Run the application
Run below command to start the app

```
$ ruby main.rb
```
This will prompt for dataset input like below
```
Please select a dataset file number from the below list:
1. data/dataset.yml
```
Select 1 and press enter. Now it will prompt for template input like below
```
Please select a template file number from the below list:
1. data/template_one.txt
2. data/template_two.txt
```
Select 1 or 2 and press enter. You will receive `A T&C Document has been generated` and a `tnc_document.txt` file will be generated in `tmp` folder.
```
A T&C Document has been generated in tmp folder.
```
Here is the sample how it looks like.
```
Please select a dataset file number from the below list:
1. data/dataset.yml
1
Please select a template file number from the below list:
1. data/template_one.txt
2. data/template_two.txt
2

A T&C Document has been generated in tmp folder.
```
You will receive a wrong input message in case when you select invalid file number. See below sample
```
Please select a dataset file number from the below list:
1. data/dataset.yml
2 #=> Wrong input, right input should be 1.
Sorry wrong input 2.
Please select a dataset file number from the below list:
1. data/dataset.yml
1
Please select a template file number from the below list:
1. data/template_one.txt
2. data/template_two.txt
3 #=> Wrong input, right input should be 1 or 2.
Sorry wrong input 3.
Please select a template file number from the below list:
1. data/template_one.txt
2. data/template_two.txt
2

A T&C Document has been generated in tmp folder.
```
### Add your own datasets and/or templates
You can use your own datasets and/or templates to generate the T&C document.
#### Add Dataset
I'm using `yaml` file format for dataset. Please have a look at `data/dataset.yml` file to checkout how `clauses` and `sections` are placed.

Create your own dataset yml (e.g. `dataset_custom.yml`) file and move that in `data` folder. Now if you re-run the app, your dataset file will be displayed in the list in alphabetical order.

```
Please select a dataset file number from the below list:
1. data/dataset.yml
2. data/dataset_custom.yml
```
#### Add Template
For template, I'm using `txt` file format. Please have a look at `data/template_one.txt` file.

Create your own template (e.g. `template_custom.txt`) file and move that in `data` folder. Now if you re-run the app, your template file will be displayed in the list in alphabetical order.
```
Please select a template file number from the below list:
1. data/template_custom.txt
2. data/template_one.txt
3. data/template_two.txt
```
## Automated tests
Using `rspec` for testing and `simplecov` for test coverage.
#### RSpec
Use below command to run the test suites.
```
$ bundle exec rspec
```
#### Test Coverage (Simplecov)
Using `simplecov` to record the test coverage. The code coverage get recorded in `coverage` folder. To see the result, open the `coverage/index.html` file in browser after running the `rspec`.

I have achieved 100% code coverage in this project. See attached screenshot.

## Design decisions
All my design decisions are based on the given time range (4-6 hours).
#### App design
This app has mainly two classes.

(1) DocumentParser
  - It parses the template data and return the parsed contents to be generated.
  - It generates the T&C document with given parsed contents.

(2) DocumentGenerator
  - It execute the program and ask and collect user input.
  
There is also a `main.rb` file to start the app

#### Error handling
The app is enable to rescue and print the error in a nice way if any exceptions raised.

#### Data (dataset and templates)
To consider the given time and **not over engineering**, I have decided to go with static datasets rather than import and parse.

But user is able to create and use their dataset and templates to generate the T&C document. Please have a look at Add your own datasets and/or templates instructions above.
## Development time
It took me 5 hours to complete and 30 minutes for documentation.
#### What I would have done given more time?
Well I would like to make it more dynamic where user can import the clauses and sections and use them to generate the T&C document.

At the moment, I'm using `yml` file format for dataset. It's hard to create a `yml` for non-technical user. To overcome this issue, I would like to add a functionality where user can use a `txt` file to import clauses and sections and use them to generate the T&C document.  
## Thank you
Hope you found the given instructions helpful.

## Developer
Nitin Srivastava
