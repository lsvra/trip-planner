//
//  MapViewModelTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 04/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

@testable import Trip_Planner
import XCTest

class MapViewModelTests: XCTestCase {
    
    var viewModel: MapViewModel?

    override func setUp() {
        super.setUp()
        
        //Vars revelant for testing purposes
        let coordinates = [Coordinate(lat: 51.5285582, long: -0.241681),
                           Coordinate(lat: 41.14961, long: -8.61099),
                           Coordinate(lat: 123, long: 321)]

        viewModel = MapViewModel(coordinates: coordinates)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testNumberOfAnnotations() {
        
        guard let viewModel = viewModel else {
            XCTFail("Fail: The viewModel is nil")
            return
        }
        
        // 1. given
        let promise = expectation(description: "Completion handler invoked")
        let expectedAnnotationsCount = 2
        var annotationsCount: Int?
        
        viewModel.displayAnnotations = { annotations in
            
            annotationsCount = annotations.count
            
            promise.fulfill()
        }
        
        // 2. when
        viewModel.requestAnnotations()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // 3. then
        XCTAssertEqual(annotationsCount, expectedAnnotationsCount, "Fail: The number of annotations is diferent than expected")
    }
}
