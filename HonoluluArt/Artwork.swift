//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Данил Ильчишин on 4/25/16.
//  Copyright © 2016 KRUBERLICK. All rights reserved.
//

import Foundation
import MapKit

//importing the AddressBook framework besause it contains
//some dictionary key constants such as kABPersonAddressStreetKey, which
//we need to set the address or city or state fields of a location
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
    
    //create the MKMapItem for Maps app
    //Maps is able to read this MKMapItem object and display correct thing
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary as? [String : String])
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = title
        
        return mapItem
    }
    
    
    
    //MARK: JSON Parsing
    
    //parse JSON array and create ArtWork object from it
    class func fromJSON(json: [JSONValue]) -> Artwork? {
        
        //location's title
        var title: String
        
        //read title from JSON or assing an empty string
        if let titleOrNil = json[16].string {
            title = titleOrNil
        } else {
            title = ""
        }
        
        //read location address
        let locationName = json[12].string
        
        //read discipline
        let discipline = json[15].string
        
        //read latitude and longitude values
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = (json[19].string! as NSString).doubleValue
        
        //create a coordinate object from read values
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //return initialized Artwork object
        return Artwork(title: title, locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
    
    
    
    //MARK: Another helper methods
    
    //set the pin color based on artworks's discipline
    func pinColor() -> MKPinAnnotationColor {
        switch discipline {
        case "Sculpture", "Plaque":
            return .Red
        case "Mural", "Monument":
            return .Purple
        default:
            return .Green
        }
    }
}