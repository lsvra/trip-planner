//
//  PlannerViewControllerTextField.swift
//  Trip Planner
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import Foundation
import UIKit

//MARK: UITextFieldDelegate
extension PlannerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        
        return true
    }
}
