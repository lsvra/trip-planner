//
//  Errors.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation

enum ConnectionsError: Error {
    case networkError
    case noInternetConnection
    case parsingError
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
        case .unknownError:
            return "error_message_unknown"
        }
    }
}
