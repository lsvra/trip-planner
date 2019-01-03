//
//  Graph.swift
//  Trip Planner
//
//  Created by Luís Vieira on 02/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

import GameplayKit

class Graph {
    
    let graph = GKGraph()
    var nodesDict = [String: GraphNode]()
    
    init(data: Graphable) {
        
        let nodeIds = data.getNodeIds()
        let connections = data.getConnections()
        
        for id in nodeIds {
            nodesDict[id] = GraphNode(id: id)
        }
        
        for connection in connections {
            
            if let startNode = nodesDict[connection.start], let endNode = nodesDict[connection.end] {
                
                let cost = Float(connection.cost)
                startNode.addConnection(to: endNode, bidirectional: false, cost: cost)
            }
        }
        
        let nodes = Array(nodesDict.values)
        graph.add(nodes)
    }
    
    func getCheapestPath(from startNode: String, to endNode: String) -> GraphPath? {
        
        guard let path = findPath(from: startNode, to: endNode) else {
            return nil
        }
        
        guard let formatedPath = getFormatedPath(from: path) else {
            return nil
        }
        
        return formatedPath
    }
    
    private func getFormatedPath(from nodes: [GraphNode]) -> GraphPath?{
       
        var nodeIds = [String]()
        var cost: Float = 0.0
        
        guard nodes.count > 1 else {
            return nil
        }
        
        for i in 0..<nodes.count {
            
            nodeIds.append(nodes[i].id)
            
            if i < nodes.count - 1 {
                cost += nodes[i].cost(to: nodes[i+1])
            }
        }
        
        return GraphPath(path: nodeIds, cost: cost)
    }
    
    private func findPath(from: String, to: String) -> [GraphNode]?{

        guard let startNode = nodesDict[from], let endNode = nodesDict[to] else {
            return []
        }
        
        let path = graph.findPath(from: startNode, to: endNode)
        
        return path as? [GraphNode]
    }
}
