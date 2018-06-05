//
//  FindViewController.swift
//  Komek
//
//  Created by Бексултан on 23.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit
//import CoreLocation
import MapKit
import Firebase
import FirebaseDatabase

class FindViewController: UIViewController, MKMapViewDelegate{
    var isHave = false
    @IBOutlet weak var mapView: MKMapView!
    //private var locationManager: CLLocationManager!
    //private var currentLocation: CLLocation?
    @IBOutlet var profButtons: [UIButton]!
    var longitude = 1.1
    var latitude = 1.1
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        let location = CLLocationCoordinate2D(latitude: 43.207720, longitude: 76.669196)
        let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center:location, span: span)
        self.mapView.setRegion(region, animated: true)
      //  locationManager = CLLocationManager()
        //locationManager.delegate = self
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        ref = Database.database().reference()
        
        
        // Check for Location Services
        
        /*if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }*/

        // Do any additional setup after loading the view.
    }
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 2000, 2000)
                mapView.setRegion(viewRegion, animated: false)
                longitude = Double(userLocation.coordinate.longitude)
                latitude = Double(userLocation.coordinate.latitude)
            }
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            print("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.pinTintColor = UIColor.blue
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        let button = UIButton(type: .detailDisclosure) as UIButton // button with info sign in it
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "editAnnotation", sender: view)
        }
    }
    
    
    
    @IBAction func handleSelection(_ sender: UIButton) {
        profButtons.forEach{ (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAnnotation"{
            let destination = segue.destination as! UsersViewController
            destination.name.text = (sender as! MKAnnotationView).annotation!.title!
            destination.telNumber.text = (sender as! MKAnnotationView).annotation!.subtitle!
            
        }
    }*/
    enum Proffs: String {
        case doctor = "Doctor"
        case plumber = "Plumber"
        case itSpec = "IT Spec"
        case teacher = "Teacher"
    }
    
    @IBAction func profTapped(_ sender: UIButton) {
        if(isHave){
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.isHave = false
        }
        guard let title = sender.currentTitle, let prof = Proffs(rawValue: title) else{
            return
        }
        switch prof {
        case .doctor:
            self.ref.observe(.childAdded, with: { (snapshot) in
                if let value = snapshot.value as? [String:Any]{
                    if value["job"] as? String == "Doctor"{
                        let userDict = snapshot.value as! [String: Any]
                        let longitude1 = userDict["longitude"] as! String
                        let latitude1 = userDict["latitude"] as! String
                        let name1 = userDict["name"] as! String
                        let tel1 = userDict["telnumber"] as! String
                        let age1 = userDict["age"] as! String
                        let surname1 = userDict["surname"] as! String
                        
                        if((Double(longitude1)! <= self.longitude + 15) || (Double(longitude1)! >= self.longitude - 15)
                            || (Double(latitude1)! <= self.latitude + 15) || (Double(latitude1)! >= self.latitude - 15)){
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude1)!, longitude: Double(longitude1)!)
                            annotation.title = name1
                            annotation.subtitle = tel1
                            self.mapView.addAnnotation(annotation)
                            self.isHave = true
                            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                                if segue.identifier == "editAnnotation"{
                                    let destination = segue.destination as! UsersViewController
                                    destination.name.text = name1
                                    destination.telNumber.text = tel1
                                    destination.age.text = age1
                                    destination.job.text = "Doctor"
                                    destination.surname.text = surname1
                                    
                                }
                            }
                            
                        }
                    }
                }
                
            }, withCancel: nil)
        case .plumber:
            self.ref.observe(.childAdded, with: { (snapshot) in
                if let value = snapshot.value as? [String:Any]{
                    if value["job"] as? String == "Plumber"{
                        let userDict = snapshot.value as! [String: Any]
                        let longitude1 = userDict["longitude"] as! String
                        let latitude1 = userDict["latitude"] as! String
                        let name1 = userDict["name"] as! String
                        let tel1 = userDict["telnumber"] as! String
                        let age1 = userDict["age"] as! String
                        let surname1 = userDict["surname"] as! String
                        
                        if((Double(longitude1)! <= self.longitude + 15) || (Double(longitude1)! >= self.longitude - 15)
                            || (Double(latitude1)! <= self.latitude + 15) || (Double(latitude1)! >= self.latitude - 15)){
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude1)!, longitude: Double(longitude1)!)
                            self.mapView.addAnnotation(annotation)
                            annotation.title = name1
                            annotation.subtitle = tel1
                            self.isHave = true
                            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                                if segue.identifier == "editAnnotation"{
                                    let destination = segue.destination as! UsersViewController
                                    destination.name.text = name1
                                    destination.telNumber.text = tel1
                                    destination.age.text = age1
                                    destination.job.text = "Plumber"
                                    destination.surname.text = surname1
                                    
                                }
                            }
                            
                        }
                    }
                }
                
            }, withCancel: nil)
        case .teacher:
            self.ref.observe(.childAdded, with: { (snapshot) in
                if let value = snapshot.value as? [String:Any]{
                    if value["job"] as? String == "Teacher"{
                        let userDict = snapshot.value as! [String: Any]
                        let longitude1 = userDict["longitude"] as! String
                        let latitude1 = userDict["latitude"] as! String
                        let name1 = userDict["name"] as! String
                        let tel1 = userDict["telnumber"] as! String
                        let age1 = userDict["age"] as! String
                        let surname1 = userDict["surname"] as! String
                        
                        if((Double(longitude1)! <= self.longitude + 15) || (Double(longitude1)! >= self.longitude - 15)
                            || (Double(latitude1)! <= self.latitude + 15) || (Double(latitude1)! >= self.latitude - 15)){
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude1)!, longitude: Double(longitude1)!)
                            self.mapView.addAnnotation(annotation)
                            annotation.title = name1
                            annotation.subtitle = tel1
                            self.isHave = true
                            
                            
                        }
                    }
                }
                
            }, withCancel: nil)
        case .itSpec:
            self.ref.observe(.childAdded, with: { (snapshot) in
                if let value = snapshot.value as? [String:Any]{
                    if value["job"] as? String == "IT Spec"{
                        let userDict = snapshot.value as! [String: Any]
                        let longitude1 = userDict["longitude"] as! String
                        let latitude1 = userDict["latitude"] as! String
                        let name1 = userDict["name"] as! String
                        let tel1 = userDict["telnumber"] as! String
                        let age1 = userDict["age"] as! String
                        let surname1 = userDict["surname"] as! String
                        
                        
                        if((Double(longitude1)! <= self.longitude + 15) || (Double(longitude1)! >= self.longitude - 15)
                            || (Double(latitude1)! <= self.latitude + 15) || (Double(latitude1)! >= self.latitude - 15)){
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: Double(latitude1)!, longitude: Double(longitude1)!)
                            self.mapView.addAnnotation(annotation)
                            annotation.title = name1
                            annotation.subtitle = tel1
                            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                                if segue.identifier == "editAnnotation"{
                                    let destination = segue.destination as! UsersViewController
                                    destination.name.text = name1
                                    destination.telNumber.text = tel1
                                    destination.age.text = age1
                                    destination.job.text = "IT Spec"
                                    destination.surname.text = surname1
                                    
                                }
                            }
                            self.isHave = true
                            
                        }
                    }
                }
                
            }, withCancel: nil)
        default:
            print("")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
