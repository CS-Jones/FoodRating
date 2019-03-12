//
//  allRestaurants.swift
//  FoodRating
//
//  Created by Callum Jones on 02/03/2018.
//  Copyright © 2018 Callum Jones. All rights reserved.
//

import UIKit
import MapKit


class allRestaurants: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {


    // Empty Array - All Restaurants
    var allTheRestaurants = [Restaurants]()
     let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask for Authorisation from the user
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            
        }
      
        // get location on startup
        
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
 
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude!)&long=\(longitude!)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { print("Error with Data");return }
            do{
                self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data);
                DispatchQueue.main.async {
                  
                }
                
                
            } catch let err {
                print("Error:" , err)
            }
            }.resume()

        
    }

}

