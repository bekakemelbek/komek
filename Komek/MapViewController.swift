//
//  MapViewController.swift
//  Komek
//
//  Created by Бексултан on 24.04.2018.
//  Copyright © 2018 Бексултан. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var count = 1
    
    @IBAction func okButton(_ sender: UIButton) {
        ProfileViewController.isVisible = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: 43.207720, longitude: 76.669196)
        let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center:location, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: self.mapView)
        let locCoord = self.mapView.convert(location, toCoordinateFrom:self.mapView)
        ProfileViewController.longitude1 = locCoord.longitude
        ProfileViewController.latitude1 = locCoord.latitude
        
        if(count == 1){
         let annotation = MKPointAnnotation()
            annotation.coordinate = locCoord
            annotation.title = "Address"
            annotation.subtitle = "Your Location"
            self.mapView.addAnnotation(annotation)
            count = count + 1
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
