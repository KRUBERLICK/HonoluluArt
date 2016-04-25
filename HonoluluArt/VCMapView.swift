//
//  VCMapView.swift
//  HonoluluArt
//
//  Created by Данил Ильчишин on 4/25/16.
//  Copyright © 2016 KRUBERLICK. All rights reserved.
//

import Foundation
import MapKit

//defines the extension of ViewController class that conforms to MKMapViewDelegate
//to handle some importants methods
extension ViewController: MKMapViewDelegate {
    
    //MARK: MKMapViewDelegate
    
    //initialize the view for the annotation
    //this method gets called every time a new annotation is added to the map
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        //try to cast given annotation to Artwork class
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            var view: MKAnnotationView
            
            //check if a reusable annotation is available
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                //if reusable annotation is not available - setup what to show in the callout
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    
    
    //MARK: Maps app setup
    
    //gets called when user taps the info button in annotation callout
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //Artwork objects that belongs to tapped pin
        let location = view.annotation as! Artwork
        
        //set launch options
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        //launch the Maps app
        location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }
}
