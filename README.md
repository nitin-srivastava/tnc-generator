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
## Thank you
Hope you found the given instructions helpful.

## Developer
Nitin Srivastava
