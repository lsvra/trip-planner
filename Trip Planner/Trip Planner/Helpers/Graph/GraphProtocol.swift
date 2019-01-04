//
//  GraphProtocol.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

//To be implemented by a dataset that needs to be transformed into a graph

protocol Graphable {
    func getNodeIds() -> Set<String>
    func getConnections() -> [GraphConnection]
}
