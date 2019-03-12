//
//  ViewController.swift
//  FoodRating
//
//  Created by Callum Jones on 19/02/2018.
//  Copyright © 2018 Callum Jones. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate,MKMapViewDelegate {

    
    @IBOutlet weak var Bus_Post: UISegmentedControl!
    
    @IBAction func refreshButton(_ sender: Any) {
        
        // All used to refresh page after searching - so reloads URL based on latitude and longitude.
        
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude

          let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude!)&long=\(longitude!)")
        
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { print("Error with Data");return }
            do{
                self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data);
                DispatchQueue.main.async {
                    self.myTableView.reloadData();
                }
                
                
            } catch let err {
                print("Error:" , err)
            }
            }.resume()
        
        
    
        
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBAction func SearchButton(_ sender: Any) {
        
        search(query: searchBar.text!)
    }
    

    // Empty Array - All Restaurants
        var allTheRestaurants = [Restaurants]()

  
    let locationManager = CLLocationManager()
    
override func viewDidLoad() {
    
    super.viewDidLoad()
    myTableView.dataSource = self
    myTableView.delegate = self
    
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
                self.myTableView.reloadData();
            }
            
            
        } catch let err {
            print("Error:" , err)
        }
        }.resume()
    
  
    }
   

    // used to populate the list of restaurants
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTheRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CellInter
        let RatingValue = allTheRestaurants[indexPath.row].RatingValue
      
        // sets label to the name of restaurant
        
        cell.BusinessLabel.text = "\(allTheRestaurants[indexPath.row].BusinessName!)"
        
        
        // changes cell image based on the rating value of the restaurant
        
        if (RatingValue == "0")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_0_en-gb")
        }
        else if (RatingValue == "1")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_1_en-gb")
        }
        else if (RatingValue == "2")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_2_en-gb")
        }
        else if (RatingValue == "3")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_3_en-gb")
        }
        else if (RatingValue == "4")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_4_en-gb")
        }
        else if (RatingValue == "5")
        {
            cell.ImageRating.image = UIImage(named:"fhrs_5_en-gb")
        }
        else if (RatingValue == "-1")
        {
            cell.ImageRating.image = UIImage(named:"fhis_exempt")
        }
 
        return cell
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let cell = sender as? UITableViewCell{
            
            let i = myTableView.indexPath(for: cell)!.row
            
            if segue.identifier == "details" {
                let dvc = segue.destination as! RestaurantsDetails
                dvc.theRestaurants = self.allTheRestaurants[i]
                
            }
            
        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        
        
        let url = URL(string: "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_loc&lat=\(latitude!)&long=\(longitude!)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { print("Error with Data");return }
            do{
                self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data);
                DispatchQueue.main.async {
                    self.myTableView.reloadData();
                }
                
                
            } catch let err {
                print("Error:" , err)
            }
            }.resume()
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations[0], completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                if let name = firstLocation?.name {
                    if let country = firstLocation?.name {
                        self.LocationLabel.text = "\(name)"
                    }
                    
                } else {
                    self.LocationLabel.text = "Locations details not available!"
                }
            
        }
            else {
            // error message
            if let error = error {
            print("Error Message \(error)")
            }
        }

        
    })
        
    
        
    
        
        
    }
    
    func search(query: String){
        var urlstring = ""
        let Stringsearch = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        // checks the bar isnt empty
        // check what segment is selected
        if searchBar.text != ""
            
        {
           let index=Bus_Post.selectedSegmentIndex
            
            if index == 0 {
                
                urlstring = "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_name&name=\(Stringsearch!)"
            }
            if index == 1
            {
                urlstring = "http://radikaldesign.co.uk/sandbox/hygiene.php?op=s_postcode&postcode=\(Stringsearch!)"
                
            }
            
            let url = URL(string: urlstring)
            
            URLSession.shared.dataTask(with: url!) { (data,response,error) in               
                guard let data = data else {print("error with data"); return}
                do{
                    self.allTheRestaurants = try JSONDecoder().decode([Restaurants].self, from: data)
                    
                    if self.allTheRestaurants.count == 0{
                        DispatchQueue.main.async{
                            let alertController = UIAlertController(title: "ERROR!", message: "Search Input is wrong, Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "dismiss", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alertController, animated: true, completion:nil)
                            
                            
                        }
                        
                    }
                    else {
                        DispatchQueue.main.async {
                            self.myTableView.reloadData();
                        }
                    }
                }
                
                catch let err {
                    print("error" , err )
                }
            }.resume()
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
 
    





