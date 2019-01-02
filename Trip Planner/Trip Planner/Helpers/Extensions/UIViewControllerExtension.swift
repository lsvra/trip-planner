//
//  UIViewControllerExtension.swift
//  Trip Planner
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(UIViewController.dismissKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
