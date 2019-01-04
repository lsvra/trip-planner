//
//  MapViewControllerMKMap.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = Color.mainColor.color()
            renderer.lineWidth = 4
            
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MapAnnotation {
            
            let pin = MKPinAnnotationView()
            pin.pinTintColor = Color.mainColorDark.color()
            return pin
        }
        
        return MKAnnotationView()
    }
}
