//
//  PlannerError.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

enum PlannerError: Error {
    case networkError
    case noInternetConnection
    case parsingError
    case tripUnavailable
    case unknownError
    
    func title() -> String {
        return "error_title"
    }
    
    func message() -> String {
        switch self {
        case .networkError:
            return "error_message_network"
        case .noInternetConnection:
            return "error_message_no_internet_connection"
        case .parsingError:
            return "error_message_parsing_data"
        case .tripUnavailable:
            return "error_message_trip_unavailable"
        case .unknownError:
            return "error_message_unknown"
        }
    }
}
