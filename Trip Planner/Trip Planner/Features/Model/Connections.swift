//
//  Connections.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

// Model file accessible by all the Features in the app

struct Connections: Decodable {
    let connections: [Connection]
}

struct Connection: Decodable {
    let from: String
    let to: String
    let price: Int
    
    let coordinates: Coordinates
}

struct Coordinates: Decodable {
    let from: Coordinate
    let to: Coordinate
}

struct Coordinate: Decodable {
    let lat: Double
    let long: Double
}
