//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Данил Ильчишин on 4/25/16.
//  Copyright © 2016 KRUBERLICK. All rights reserved.
//

import UIKit

//import the MapKit framework
import MapKit

class ViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    //MARK: Properties
    
    let regionRadius: CLLocationDistance = 1000 //distance value (in meters) for the correct zoom
    
    
    
    //MARK: Map view setup
    
    //center map view on over the given location with zoom value, initialized before
    func centerMapOnLocation(location: CLLocation) {
        
        //setup square region
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        //set region to map view
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    // MARK: Overrided methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //center map's location to initial location
        centerMapOnLocation(initialLocation)
    }
}

