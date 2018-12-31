//
//  Endpoint.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation

// Constants that are used more than once
struct APIConstants {
    fileprivate static let scheme: String = "https"
    fileprivate static let host: String = "raw.githubusercontent.com"
    fileprivate static let path: String = "/TuiMobilityHub/ios-code-challenge/master/connections.json"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = APIConstants.host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func connections() -> Endpoint {
        
        return Endpoint(
            path: APIConstants.path,
            queryItems: nil) //No query item needed for this request
    }
}
