//
//  MapError.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

enum MapError: Error {
    case drawingError
    case unknownError
    
    func title() -> String {
        return "error_title"
    }
    
    func message() -> String {
        switch self {
        case .drawingError:
            return "error_message_drawing"
        case .unknownError:
            return "error_message_unknown"
        }
    }
}
