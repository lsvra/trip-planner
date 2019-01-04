//
//  ConnectionsExtension.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

//Implementation of the Graphable protocol

extension Connections: Graphable {
    
    func getNodeIds() -> Set<String> {
        var nodeIds = Set<String>()
        
        connections.forEach({
            nodeIds.insert($0.from)
            nodeIds.insert($0.to)
        })
        
        return nodeIds
    }
    
    func getConnections() -> [GraphConnection] {
        
        var edges = [GraphConnection]()
        
        connections.forEach({
            
            let edge = GraphConnection(start: $0.from, end: $0.to, cost: Float($0.price))
            edges.append(edge)
        })
        
        return edges
    }
}
