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
    
    //TODO: Find a better way of reusing this method
    func displayError(title: String, message: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized(),
                                      style: .default,
                                      handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
