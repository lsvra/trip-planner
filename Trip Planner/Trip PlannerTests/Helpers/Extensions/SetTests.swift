//
//  SetTests.swift
//  Trip PlannerTests
//
//  Created by Luís Vieira on 02/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

@testable import Trip_Planner
import XCTest

class SetTests: XCTestCase {
    
    var set: Set<String>?
    
    override func setUp() {
        super.setUp()
        
        set = Set<String>()
        
        set?.insert("Porto")
        set?.insert("Vila Real")
        set?.insert("Mesão Frio")
    }
    
    override func tearDown() {
       
        set = nil
        super.tearDown()
    }
    
    func testMatch(){
        
        // 1. given
        let text = "Po"
        let expectedMatch = "Porto"
        
        // 2. when
        guard let set = set else {
            XCTFail("Fail: The set has not been initialized")
            return
        }
        
        let match = set.getMatch(for: text)
        
        // 3. then
        XCTAssertEqual(match, expectedMatch, "Fail: The match does not correspond")
    }
    
    func testMatchWithSpaces(){
        
        // 1. given
        let text = "Vila "
        let expectedMatch = "Vila Real"
        
        // 2. when
        guard let set = set else {
            XCTFail("Fail: The set has not been initialized")
            return
        }
        
        let match = set.getMatch(for: text)
        
        // 3. then
        XCTAssertEqual(match, expectedMatch, "Fail: The match does not correspond")
    }
    
    func testMatchWithSpecialCharacters(){
        
        // 1. given
        let text = "Mes"
        let expectedMatch = "Mesão Frio"
        
        // 2. when
        guard let set = set else {
            XCTFail("Fail: The set has not been initialized")
            return
        }
        
        let match = set.getMatch(for: text)
        
        // 3. then
        XCTAssertEqual(match, expectedMatch, "Fail: The match does not correspond")
    }
}
