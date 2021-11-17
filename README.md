# MARS ROVER Tech Challenge APP

## Table of Contents
* [Overview](#overview)
* [System dependencies](#system-dependencies)
* [Architecture](#architecture)
* [Database](#database)
* [Testing](#testing)
* [Deployment instructions](#deployment-instructions)
* [Future refactoring](#future-refactoring)


## Overview:
The basis for this project is the Google Mars Rover Technical Challenge (which can be viewed here: https://code.google.com/archive/p/marsrovertechchallenge/ ). I chose to do this project because it struck me as an interesting challenge, and I decided I wanted to put some of my Ruby on Rails skills to the test.
Also because it's fun to imagine controlling a rover on Mars!

This is a Ruby on Rails web application which allows any user to create a plateau on Mars which they would like to explore with a rover, with a special specification that the plateau must be rectangular.
A user can create rovers to explore a plateau, sending movement instructions to the rovers. These movement instructions may be one, or a series of, 'L', to turn left, 'R', to turn right, or 'M', to move the rover forwards.

This web application was designed according to RESTful architecture, in that objects can be created, shown, listed, updated and destroyed, to the extent that those actions make sense for a given object.


## System dependencies
### The following gems were used to create this app:
    ruby 3.0.2p107
    Rails 6.1.4.1
    sqlite 1.4.2
    puma 5.5.2
    bootstrap-sass 3.4.1
    sass-rails 6.0.0
    webpacker 5.4.3
    turbolinks 5.2.1
    jbuilder 2.11.3
    bootsnap 1.9.1
    will_paginate 3.3.0
    bootstrap-will_paginate 1.0.0
### To install the above gems, as well as those required for testing (below), execute the following command:
    bundle install
  

## Architecture
### Models
#### Plateau
##### The plateau model has the following attributes:
      - name (string)
      - top_right_x_coordinate (integer)
      - top_right_y_coordinate (integer)
      - explored (boolean)
      - has_many rovers
#### Rover
##### The rover model has the following attributes:
      - name (string)
      - heading (string)
      - x_coordinate (integer)
      - y_coordinate (integer)
      - belongs_to plateau
### Controllers
#### Plateaus
##### The plateaus controller has the following actions: 
        new, create, show, index, edit, update, destroy
      - When creating a new plateau, the user is required to give it a name and define a rectangular border by specifying the top right x and y coordinates, while the explored attribute is set to false by default.
      - In the edit view the user can only edit the name and top right coordinates for the plateau (a button for the explored attribute is used in the plateau show view to update the explored attribute from false to true, and vice versa).
      - The the new and index views can both be accessed from the header navbar, and the new view can also be accessed from the index view.
      - A plateau is destroyed via a link on the specific plateau's show view
#### Rovers
##### The rovers controller has the following actions: 
        new, create, edit, update, destroy, move, update_position as well as private actions for handling movement instructions (checking the validity of the instructions, altering the coordinates of the rover and its heading based on the movement instructions, etc.)
      - Creating a new rover is done via the plateau show view. The user is required to input a name for the rover, while the heading and coordinate position for the rover are determined randomly, to simulate the difficulty of dropping a rover on Mars with any degree of accuracy (the only certainty is that the rover will land within the plateau baoundary).
      - Rovers, along with their headings and coordinates, are listed on the plateau show view, with links for their edit and move views, as well as a link to destroy the specified rover.
      - A user can only edit the name of a rover through the edit action and view, while editing the rover position and heading is done through the move action and view.


## Database
### To create the database, execute the following command:
      bundle exec rake db:migrate


## Testing
### Dependencies
      rspec-rails 4.1.2
      factory_bot_rails 4.11.1
      shoulda-matchers 3.1.3
      database_cleaner 2.0.1
### After installing the above gems, execute the command below to run the test suite:
      bundle exec rspec


## Deployment instructions
### You can start the rails server by executing the command below:
      rails s
#### You will then be able to visit the site using the URL: 
      http://localhost:3000
      
      
## Future refactoring
### I consider the following as important refactoring considerations:
      - Paginating rovers on the plateau show view
      - Refactoring the movement instruction implementation methods
      - User login and authentication system with sessions
      - Improving the plateau show view with images of plateaus and a grid upon which the rovers exist for ease of use
      - Splitting the app into an API and a frontend

