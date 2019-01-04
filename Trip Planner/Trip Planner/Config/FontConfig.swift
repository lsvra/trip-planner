//
//  FontConfig.swift
//  Trip Planner
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation
import UIKit

enum Font {
    case regular
    case bold
    case light
    
    func name() -> String {
        switch self {
        case .regular:
            return "HelveticaNeue"
        case .bold:
            return "HelveticaNeue-Bold"
        case .light:
            return "HelveticaNeue-Light"
        }
    }
}
