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
    case textColorDark
    case textColorRed
    case white
    case gray
    
    func color() -> UIColor {
        switch self {
        case .mainColor:
            return UIColor(red: 0.48, green: 0.25, blue: 0.96, alpha: 1.0)
        case .mainColorDark:
            return UIColor(red: 0.32, green: 0.15, blue: 0.70, alpha: 1.0)
        case .secondaryColor:
            return UIColor(red: 0.75, green: 0.98, blue: 0.59, alpha: 1.0)
        case .textColorDark:
            return .darkText
        case .textColorRed:
            return .red
        case .white:
            return .white
        case .gray:
            return .lightGray
        }
    }
}
