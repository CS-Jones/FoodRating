//
//  FoodRating
//
//  Created by Callum Jones on 23/03/2018.
//  Copyright © 2018 Callum Jones. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MapView:UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var PinMap: MKMapView!
    
    
    var allTheRestaurants = [Restaurants]()
    var theRestaurants: Restaurants?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        PinMap.delegate = self
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: latitude!,  longitude: longitude!)
        let region = MKCoordinateRegion (center: center, span: MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01))
        
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
            
        }
        PinMap.setRegion(region, animated:true)
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude!)&long=\(longitude!)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { print("Error with Data");return }
            do{
                self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data);
                
            } catch let err {
                print("Error:" , err)
            }
            }.resume()
        
        
        
        do {
            let data = try Data (contentsOf: url!)
            self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data);
       
        
        for i in self.allTheRestaurants {
            let annotation = CustomPin()
            let latitude = (i.Latitude as! NSString).doubleValue
            let longitude = (i.Longitude as! NSString).doubleValue
            if (i.RatingValue == "0"){
                annotation.image = UIImage(named: "0")
            } else if (i.RatingValue == "1"){
                annotation.image = UIImage(named: "1")
            } else if (i.RatingValue == "2"){
                annotation.image = UIImage(named: "2")
            } else if (i.RatingValue == "3"){
                annotation.image = UIImage(named: "3")
            } else if (i.RatingValue == "4"){
                annotation.image = UIImage(named: "4")
            } else if (i.RatingValue == "5"){
                annotation.image = UIImage(named: "5")
            } else if (i.RatingValue == "-1"){
                annotation.image = UIImage(named: "E")
                
            }
            
            annotation.coordinate = CLLocationCoordinate2DMake(latitude,longitude)
            annotation.title = i.BusinessName
            // annotation.subtitle = theRestaurants?.DistanceKM
            self.PinMap.addAnnotation(annotation)
            print("test")
        }
            
        } catch let err {
            print(err)
        }
        
   
        
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



