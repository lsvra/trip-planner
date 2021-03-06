//
//  CoordinatesExtension.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

//Implementation of the Mappable protocol

import MapKit

extension Coordinate: Mappable {
    
    func get2DCoordinate() -> CLLocationCoordinate2D? {
        
        guard let latitude = CLLocationDegrees(exactly: lat), let longitude = CLLocationDegrees(exactly: long) else {
            return nil
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        //Check if the coordinate is a valid one
        guard CLLocationCoordinate2DIsValid(coordinate) else {
            return nil
        }
        
        return coordinate
        
    }
}
