//
//  PlannerParams.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation

class PlannerParams {
    
    func queue() -> OperationQueue {
        return OperationQueue()
    }
    
    func session() -> URLSession {
        return URLSession(configuration: .default)
    }
    
    func reachability() -> Reachability? {
        
        let reachability: Reachability?
        
        do {
            reachability = try Reachability()
        } catch {
            reachability = nil
        }
        
        return reachability
    }
}
