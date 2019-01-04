//
//  EndpointTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

@testable import Trip_Planner
import XCTest

class EndpointTests: XCTestCase {

    func testUrlCreation(){
        
        // 1. given
        let endpoint = Endpoint.connections()
        let expectedUrlString = "https://raw.githubusercontent.com/TuiMobilityHub/ios-code-challenge/master/connections.json"
        
        // 2. when
        let endpointUrlString = endpoint.url?.absoluteString
        
        // 3. then
        XCTAssertEqual(endpointUrlString, expectedUrlString, "Fail: The url string is malformed")
    }
}
