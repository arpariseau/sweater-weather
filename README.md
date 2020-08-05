# Sweater Weather

This API is intended to provide endpoints to work with a front-end application, providing information on whether it's sweater weather or not. 

## Endpoints:
#### GET 'api/v1/forecast'
*parameters:* ```location``` 

- gets the current, hourly and daily forecast for a certain location, including weather, temperature and more.

#### GET 'api/v1/backgrounds'
*parameters:* ```location``` 

- pulls a url to link to an image that fits both the location and current weather for that location as best it can.

#### POST 'api/v1/users' 
- registers a new user using the email and password given. Emails must be unique. Returns a unique API key for the user in the response, if successful.

*request body:*
```
{ 
  email: <user email>
  password: <password>
  password_confirmation: <password> 
}
```

#### POST 'api/v1/sessions' 
- logs a user into a session, authenticating using their password. Response will also retrieve user's unique API key.

*request body:*
```
{ 
  email: <user email>
  password: <password>
}
```

#### POST 'api/v1/road_trip' 
- creates a road trip from the origin to the destination, finding the travel time and providing the weather at the destination when they arrive. Requires a valid API key from a registered user to access.

*request body:*
```
{ 
  origin: <origin point>
  destination: <destination point>
  api_key: <user api key> 
}
```

### Works in conjunction with:
- [Mapquest API](https://developer.mapquest.com/documentation/)
- [Openweather API](https://openweathermap.org/api/one-call-api)
- [Unsplash API](https://unsplash.com/developers)

To install, acquire keys from all three of the above, then run ```bundle exec figaro install```, then copy your keys as such into the ```configs/application.yml``` file:

```
MAPQUEST_API_KEY: <your API key here>
OPENWEATHER_API_KEY: <your API key here>
UNSPLASH_API_KEY: <your API key here>
```

### Made with:
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/200px-Ruby_logo.svg.png" alt="Ruby Logo" width="25" height="25"/> v2.5.3
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/200px-Ruby_On_Rails_Logo.svg.png" alt="Rails Logo" width="75" height="25" /> v5.1.7


### Made by:
[Alex Pariseau](https://github.com/arpariseau/)
