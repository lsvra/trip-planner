//
//  NetworkingTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

@testable import Trip_Planner
import XCTest

class DataLoadOperationTests: XCTestCase {
    
    var queue: OperationQueue!
    var session: URLSession!

    override func setUp() {
        super.setUp()
        
        queue = OperationQueue()
        session = URLSession(configuration: .default)
    }

    override func tearDown() {
        queue = nil
        session = nil
        
        super.tearDown()
    }
    
    func testDataLoadOperationCode200() {
        
        // 1. given
        let urlString = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
    
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        // 2. when
        guard let url = URL(string: urlString) else {
            XCTFail("Fail: The url is nil")
            return
        }
        
        let dataLoader = DataLoadOperation(url: url, session: session)
        
        dataLoader.completion = { data, response, error in
            
            if let response = response as? HTTPURLResponse {
                statusCode = response.statusCode
            }
            
            responseError = error
            
            promise.fulfill()
        }
        
        queue.addOperation(dataLoader)
        
        waitForExpectations(timeout: 10, handler: nil)
        
        // 3. then
        XCTAssertNil(responseError, "Fail: The request returned an error")
        XCTAssertEqual(statusCode, 200, "Fail: The status code is different from 200")
    }
}
