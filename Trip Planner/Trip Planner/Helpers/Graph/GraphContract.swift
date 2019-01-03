//
//  GraphContract.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

protocol Graphable {
    func getNodeIds() -> Set<String>
    func getConnections() -> [GraphConnection]
}
