# Food Rating
Iphone App to check hygiene ratings around you.

To create an iPhone/iOS app coded in Swift 4 that communicates with a server in order to receive hygiene ratings 
for restaurants and eateries in the surrounding area.

The application was developed using the XCode 9 development environment and Swift 4.

Basic App Functionality 

The basica functionalilty of the app should use the device's GPS to establish the phone’s current latitude and longitude. the app
will make a RESTful request to the server-side script (using the current location data) to find the
nearest food serving establishments to the phone’s current location, and display the business name, and
rating for each of the results. Restaurants with a -1 rating, should have “Exempt”

Map Intergration 

When performing searches by current location, the user should have the option of viewing the search
results on a Google map, with a “pin” for each of the establishment and one pin for the users current
location. 

Search Feature 

The app allows the user to search for eateries based on business name or by postcode. To do this
the app will utilise the appropriate method/routes on the RESTFul web service in order to fulfil the
search request. The results should then be displayed in the tableview.

Details Screen 

app should have some sort of mechanism of displaying additional information about the eateries
for example the full address, date of inspection and location (preferably on a map).

