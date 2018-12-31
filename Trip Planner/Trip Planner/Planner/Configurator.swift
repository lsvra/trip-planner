//
//  Configurator.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation

final class Configurator {
    
    static func queue() -> OperationQueue {
        return OperationQueue()
    }
    
    static func session() -> URLSession {
        return URLSession(configuration: .default)
    }
    
    static func reachability() -> Reachability? {
        
        let reachability: Reachability?
        
        do {
            reachability = try Reachability()
        } catch {
            reachability = nil
        }
        
        return reachability
    }
}
