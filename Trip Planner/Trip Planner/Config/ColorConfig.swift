//
//  ColorConfig.swift
//  Trip Planner
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case mainColor
    case mainColorDark
    case secondaryColor
    case white
    
    func color() -> UIColor {
        switch self {
        case .mainColor:
            return UIColor(red: 0.69, green: 0.73, blue: 0.59, alpha: 1.0)
        case .mainColorDark:
            return UIColor(red: 0.52, green: 0.65, blue: 0.47, alpha: 1.0)
        case .secondaryColor:
            return UIColor(red: 0.85, green: 0.86, blue: 0.83, alpha: 1.0)
        case .white:
            return .white
        }
    }
}
