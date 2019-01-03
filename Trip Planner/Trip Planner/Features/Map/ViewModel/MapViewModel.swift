//
//  MapViewModel.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

import Foundation
import MapKit

class MapViewModel {
    
    //MARK: Vars
    private let coordinates: [Mappable]
    
    //MARK: MVVM Vars
    private var annotations: [MKAnnotation]? {
        didSet {
            guard let annotations = annotations else {
                return
            }
            
            self.displayAnnotations?(annotations)
        }
    }
    
    private var path: MKPolyline? {
        didSet {
            guard let path = path else {
                return
            }
            
            self.displayPath?(path)
        }
    }
    
    //MARK: MVVM Closures
    var displayAnnotations: (([MKAnnotation]) -> Void)?
    var displayPath: ((MKPolyline) -> Void)?
    
    //MARK: Lifecycle
    init(coordinates: [Mappable]) {
        self.coordinates = coordinates
    }
    
    //MARK: Methods
    func requestAnnotations() {
        
        var annotations = [MKAnnotation]()
        
        for coordinate in coordinates {
            if let mapCoordinate = coordinate.get2DCoordinate() {
                
                annotations.append(MapAnnotation(coordinate: mapCoordinate))
            }
        }
        
        self.annotations = annotations
    }
    
    func requestPathBetweenAnnotations() {
        
        var mapCoordinates = [CLLocationCoordinate2D]()
        
        for coordinate in coordinates {
            if let mapCoordinate = coordinate.get2DCoordinate() {
                mapCoordinates.append(mapCoordinate)
            }
        }
        
        let path = MKPolyline(coordinates: mapCoordinates, count: mapCoordinates.count)
        
        self.path = path
    }
}
