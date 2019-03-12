//
//  RestaurantsDetails.swift
//  FoodRating
//
//  Created by Callum Jones on 19/02/2018.
//  Copyright © 2018 Callum Jones. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsDetails: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var RatingImage: UIImageView!
    @IBOutlet weak var RatingDate: UILabel!
    @IBOutlet weak var BusinessName: UILabel!
    @IBOutlet weak var Addressline1: UILabel!
    @IBOutlet weak var Addressline2: UILabel!
    @IBOutlet weak var Addressline3: UILabel!
    @IBOutlet weak var PostCode: UILabel!
    // @IBOutlet weak var DistanceKM: UILabel!
    @IBOutlet weak var RestaurantMap: MKMapView!
    

    var theRestaurants: Restaurants?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // sets labels to required text to display
        
        RestaurantMap.delegate = self
        RestaurantMap.showsUserLocation = false
        RatingDate.text = theRestaurants?.RatingDate
        BusinessName.text = theRestaurants?.BusinessName
        Addressline1.text = theRestaurants?.AddressLine1
        Addressline2.text = theRestaurants?.AddressLine2
        Addressline3.text = theRestaurants?.AddressLine3
        PostCode.text = theRestaurants?.PostCode
        //DistanceKM.text = theRestaurants?.DistanceKM
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 50
            //locationManager.startUpdatingLocation()
            
        }
        

        
        let latitude = (theRestaurants?.Latitude! as! NSString).doubleValue
        let longitude = (theRestaurants?.Longitude! as! NSString).doubleValue
        
        let Loclatitude = locationManager.location?.coordinate.latitude
        let Loclongitude = locationManager.location?.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: latitude,  longitude: longitude)
        let region = MKCoordinateRegion (center: center, span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
        
        let _ :CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let _ :CLLocationCoordinate2D = CLLocationCoordinate2DMake(Loclatitude!,Loclongitude!)
        
        
        RestaurantMap.setRegion(region, animated: true)
        RestaurantMap.mapType = .standard
        let annotation = CustomPin()
        
        
        // Do any additional setup after loading the view.
        
        
        // changes Image based on the resaturants rating value.
        
        if (theRestaurants?.RatingValue == "0"){
            RatingImage.image = UIImage(named: "fhrs_0_en-gb")
  annotation.image = UIImage(named: "0")
        } else if (theRestaurants?.RatingValue == "1"){
            RatingImage.image = UIImage(named: "fhrs_1_en-gb")
            annotation.image = UIImage(named: "1")
        } else if (theRestaurants?.RatingValue == "2"){
            RatingImage.image = UIImage(named: "fhrs_2_en-gb")
            annotation.image = UIImage(named: "2")
        } else if (theRestaurants?.RatingValue == "3"){
            RatingImage.image = UIImage(named: "fhrs_3_en-gb")
            annotation.image = UIImage(named: "3")
        } else if (theRestaurants?.RatingValue == "4"){
            RatingImage.image = UIImage(named: "fhrs_4_en-gb")
            annotation.image = UIImage(named: "4")
        } else if (theRestaurants?.RatingValue == "5"){
            RatingImage.image = UIImage(named: "fhrs_5_en-gb")
              annotation.image = UIImage(named: "5")
        } else if (theRestaurants?.RatingValue == "-1"){
            RatingImage.image = UIImage(named: "fhis_exempt")
            annotation.image = UIImage(named: "E")
            
        }
        // adds title/subtitle to annontation of the pin on map.
        annotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
        annotation.title = theRestaurants?.BusinessName
        annotation.subtitle = theRestaurants?.DistanceKM
        RestaurantMap.addAnnotation(annotation)
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard !annotation.isKind(of: MKUserLocation.self) else {return nil}
        let annotationIdentifer = "AnnotationIdentifer"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifer)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifer)
            annotationView!.canShowCallout = true
            
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let customPointAnnotation = annotation as! CustomPin
        annotationView!.image = customPointAnnotation.image
        return annotationView
        
    }
}
