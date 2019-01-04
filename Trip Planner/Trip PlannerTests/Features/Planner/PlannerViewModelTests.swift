//
//  PlannerViewModelTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 04/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

@testable import Trip_Planner
import XCTest

class PlannerViewModelTests: XCTestCase {
    
    var viewModel: PlannerViewModel?

    override func setUp() {
        super.setUp()
        
        let session = URLSession(configuration: .default)
        let queue = OperationQueue()
        let reachability: Reachability? = nil
        
        viewModel = PlannerViewModel(session: session, queue: queue, reachability: reachability)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCitiesReload() {
        
        guard let viewModel = viewModel else {
            XCTFail("Fail: The viewModel is nil")
            return
        }
    
        // 1. given
        let promise = expectation(description: "Completion handler invoked")
        var availableCities: Set<String>?
        
        viewModel.reload = { cities in
          
            availableCities = cities
            
            promise.fulfill()
        }
        
        viewModel.displayError = { error in
            
            XCTFail("Fail: \(error.message())")
            promise.fulfill()
        }
        
        // 2. when
        viewModel.requestConnections()
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // 3. then
        XCTAssertNotNil(availableCities, "Fail: The availableCities variable is nil")
    }
}
