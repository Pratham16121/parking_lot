# Parking Lot Managment System

## Project Idea
The Parking Lot Management System is a web-based application implemented using the Ruby on Rails framework. It serves as a browser-based solution designed to work locally on a system. The system provides comprehensive features for managing and organizing parking lots efficiently. This README document provides an overview of the project and guides developers through the setup process.
## Rails Setup
- Ruby Version - 3.1.2
- Rails Version - 7.0.4
- PostgreSQL - 15.3
- To clone the project:

    `git clone git@github.com:Pratham16121/parking_lot.git`
- To navigate to the project

  `cd parking_lot`
- Install Dependencies

  `bundle install`
## Database Setup
- create a new PostgresSQL Database

  `raild db:create db:migrate`

*Note*
If this gives error make sure to setup the **database.yml** file. Copy the text from the **database.yml.example** in a new **config/database.yml** file and set the **username** and **password** of the postgres. 

- Decide a finite number of slots for implementing the project

  `rails create_slots_data:generate_slots[5,4]`

*Note*
In the above example: 5 is the number of columns. And, 4 is the number of cars in each columns. The above command will make 20 slots, named: A1-A4, B1-B4, C1-C4, D1-D4, E1-E4. 
- Start the server <br>
  `rails s`

