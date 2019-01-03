//
//  MappableProtocol.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

//To be implemented by a dataset that needs to be drawn in MKMapView

import MapKit

protocol Mappable {
    func get2DCoordinate() -> CLLocationCoordinate2D?
}
