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
    var artworks = [Artwork]() //artworks array
    
    
    
    //MARK: Map view setup
    
    //center map view over the given location with zoom value, initialized before
    func centerMapOnLocation(location: CLLocation) {
        
        //setup square region
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        //set region to map view
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    //load initial locations
    func loadInitialData() {
        
        //file with JSON
        let fileName = NSBundle.mainBundle().pathForResource("PublicArt", ofType: "json")
        
        do {
            
            //read the PublicArt.json into NSData object
            var data: NSData = try NSData(contentsOfFile: fileName!, options: .DataReadingMapped)
            
            //obtain JSON object using NSJSONSerialization
            let jsonObject: AnyObject! = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            
            //check if json object is a [String: AnyObject] dictionary
            if let jsonObject = jsonObject as? [String: AnyObject] {
                
                //filter only those JSON objects whose key is "data"
                if let jsonData = JSONValue.fromObject(jsonObject)?["data"]?.array {
                    for artworkJSON in jsonData {
                        
                        //try to create Artwork object from JSON
                        //if the object is successfuly created - append it to artworks array
                        if let artworkJSON = artworkJSON.array, artwork = Artwork.fromJSON(artworkJSON) {
                            artworks.append(artwork)
                        }
                    }
                }
            }
        } catch {
            print("Exception during file read")
        }
        
    }
    
    
    
    // MARK: Overrided methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        //load initial artworks from JSON file
        loadInitialData()
        
        //add loaded annotations to map
        mapView.addAnnotations(artworks)
        
        //center map's location to initial location
        centerMapOnLocation(initialLocation)
        
        //set the annotation that points to King David Kalakaua (just for test)
        //let artwork = Artwork(title: "King David Kalakaua",
        //                      locationName: "Waikiki Gateway Park",
        //                      discipline: "Sculpture",
        //                      coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        //add created annotation to map view
        //mapView.addAnnotation(artwork)
        
        //set map view delegate
        mapView.delegate = self
        
        
    }
}

