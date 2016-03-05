# Opendoor Code Challenge

There are a number of improvements I would make if I were to continue developing this service:

+ Validate and sanitize param values
+ Use fixtures or factories for test data
+ Use shared context and examples to DRY-up specs
+ Support PostGIS
	+ Query using GIS data (eg. 10 miles from X, within specified bounds)
    + Convert lat/lon to PostGIS point
+ Extract address & GIS data into a separate table
+ Extract pagination out into a separate module

The application can be found at:
[Opendoor Challenge on Heroku](https://opendoor-challenge.herokuapp.com)