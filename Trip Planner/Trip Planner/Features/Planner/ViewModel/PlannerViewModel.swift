//
//  PlannerViewModel.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation

final class PlannerViewModel {
    
    //MARK: Vars
    private var graph: Graph?
    var coordinates: [Mappable]?
    
    //MARK: DI Vars
    private let session: URLSession
    private let queue: OperationQueue
    private let reachability: Reachability?
    
    //MARK: MVVM Vars
    private var connections: Connections? {
        didSet {
            guard let connections = connections?.connections else {
                return
            }
            
            let cities = extractCities(from: connections)
            
            self.reload?(cities)
        }
    }
    
    private var cost: String? {
        didSet {
            if let cost = cost {
                self.displayCost?(cost)
            }
        }
    }
    
    private var error: PlannerError? {
        didSet {
            if let error = error {
                self.displayError?(error)
            }
        }
    }
    
    private var validTrip: Bool? {
        didSet {
            if let validTrip = validTrip {
                self.toggleMapButton?(validTrip)
            }
        }
    }
    
    //MARK: MVVM Closures
    var reload: ((Set<String>) -> Void)?
    var displayError: ((PlannerError) -> Void)?
    var displayCost: ((String) -> Void)?
    var toggleMapButton: ((Bool) -> Void)?

    //MARK: Lifecycle
    init(session: URLSession, queue: OperationQueue, reachability: Reachability?) {
        
        self.session = session
        self.queue = queue
        self.reachability = reachability
        self.graph = nil
        
        if self.reachability != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: .flagsChanged, object: nil)
        }
    }
    
    deinit {
        if let reachability = self.reachability {
            reachability.stop()
            NotificationCenter.default.removeObserver(self, name: .flagsChanged, object: nil)
        }
    }

    //MARK: Methods
    func requestConnections() {
        
        //Check if there is a connection available
        guard isConnectedToNetwork() else {
            self.error = .noInternetConnection
            return
        }
        
        //Get the correct url
        guard let url = Endpoint.connections().url else {
            self.error = .networkError
            return
        }
        
        //Initialize the network operation
        let dataLoader = DataLoadOperation(url: url, session: session)
        
        //Set the completion handler for the operation
        dataLoader.completion = { [weak self] data, response, error in
            
            guard let self = self else {
                return
            }
            
            if error != nil {
                self.error = .networkError
                return
            }
            
            guard let data = data else {
                self.error = .unknownError
                return
            }
            
            // Used guard let instead of try/catch in order to get a cleaner code style
            guard let result = try? JSONDecoder().decode(Connections.self, from: data) else {
                self.error = .parsingError
                return
            }
            
            //Save graph
            self.graph = Graph(data: result)
            
            //Set available cities
            self.connections = result
        }
        
        //Add the operation to the queue
        queue.addOperation(dataLoader)
    }
    
    func requestPathAndCost(from start: String, to end: String){
       
        guard let graph = graph else {
            return
        }
        
        guard let path = graph.getCheapestPath(from: start, to: end) else {
            
            self.error = .tripUnavailable
            self.cost = "-"
            self.validTrip = false
            return
        }
        
        //Set cost
        self.cost = String(format: "%.02f€", path.cost)
        
        //Set button state
        self.validTrip = true
        
        //Extract coordinates for future use
        if let connections = self.connections?.connections {
            self.coordinates = extractTripCoordinates(from: connections, using: path.path)
        }
    }
    
    @objc private func reloadView(){
        
        if isConnectedToNetwork() {
            requestConnections()
        } else {
            self.error = .noInternetConnection
            return
        }
    }
    
    private func isConnectedToNetwork() -> Bool{
        
        if let reachability = self.reachability {
            return reachability.isConnectedToNetwork
        }
        
        return true
    }
    
    private func extractTripCoordinates(from connections: [Connection], using cities: [String]) -> [Coordinate]?{
        
        var coordinates = [Coordinate]()
        
        guard cities.count > 1 else {
            return nil
        }
        
        for i in 0..<cities.count - 1 {
            
            let connection = connections.first(where: {
                $0.from == cities[i] && $0.to == cities[i + 1]
            })
            
            if let connection = connection {
                coordinates.append(connection.coordinates.from)
                coordinates.append(connection.coordinates.to)
            }
        }
        
        return coordinates
    }
    
    private func extractCities(from connections: [Connection]) -> Set<String> {
        
        var set = Set<String>()
        
        connections.forEach({
            set.insert($0.from)
            set.insert($0.to)
        })
        
        return set
    }
}
