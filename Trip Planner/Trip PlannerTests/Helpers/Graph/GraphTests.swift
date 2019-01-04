//
//  GraphTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 04/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//


@testable import Trip_Planner
import XCTest

class GraphTests: XCTestCase {
    
    var graph: Graph?
    
    override func setUp() {
        super.setUp()
        
        //Vars not revelant for testing purposes
        let coordinate = Coordinate(lat: 0.0, long: 0.0)
        let coordinates = Coordinates(from: coordinate, to: coordinate)
        
        //Vars revelant for testing purposes
        let connections = [Connection(from: "Porto", to: "London", price: 50, coordinates: coordinates),
                           Connection(from: "London", to: "Berlin", price: 120, coordinates: coordinates),
                           Connection(from: "Berlin", to: "Barcelona", price: 240, coordinates: coordinates),
                           Connection(from: "London", to: "Barcelona", price: 70, coordinates: coordinates),
                           Connection(from: "Beijing", to: "Los Angeles", price: 350, coordinates: coordinates),
                           Connection(from: "Los Angeles", to: "New York", price: 100, coordinates: coordinates)]
        
        let data = Connections(connections: connections)
        
        graph = Graph(data: data)
    }
    
    override func tearDown() {
        
        graph = nil
        super.tearDown()
    }
    
    func testCheapestPathBetweenPortoAndBarcelona() {
        
        guard let graph = graph else {
            XCTFail("Fail: The graph is nil")
            return
        }
        
        // 1. given
        let expectedCost: Float = 120.0
        
        // 2. when
        guard let path = graph.getCheapestPath(from: "Porto", to: "Barcelona") else {
            XCTFail("Fail: The path is nil")
            return
        }
        
        // 3. then
        XCTAssertEqual(path.cost, expectedCost, "Fail: The total cost for the trip is diferent than expected")
    }
}
