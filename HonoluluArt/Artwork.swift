//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Данил Ильчишин on 4/25/16.
//  Copyright © 2016 KRUBERLICK. All rights reserved.
//

import Foundation
import MapKit
import AddressBook

//defines the Artwork class for creating annotations on the map view
class Artwork: NSObject, MKAnnotation {
    
    //MARK: Properties
    
    let title: String? //annotation title
    let locationName: String //name of annotation's location
    let discipline: String //discipline
    let coordinate: CLLocationCoordinate2D //annotation coordinates
    
    //subtitle is a computed property which returns location name
    var subtitle: String? {
        return locationName
    }
    
    
    
    //MARK: Initializers
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        
        //init annotation properties
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    
    
    //MARK: Maps app setup
    
    //open maps app when user clicks on info button in annotation callout
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as? [String : String])
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}