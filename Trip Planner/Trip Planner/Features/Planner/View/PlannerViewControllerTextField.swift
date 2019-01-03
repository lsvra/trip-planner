//
//  PlannerViewControllerTextField.swift
//  Trip Planner
//
//  Created by Luís Vieira on 31/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

//MARK: UITextFieldDelegate
extension PlannerViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = .darkText
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Check array of cities
        guard let cities = availableCities else {
            return
        }
        
        //Check current text
        guard let currentText = textField.text else {
            return
        }
        
        //Set the text to red if there is no match available
        guard cities.getMatch(for: currentText) != nil else {
            DispatchQueue.main.async {
                textField.textColor = Color.textColorRed.color()
            }
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        dismissKeyboard()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Check array of cities
        guard let cities = availableCities else {
            return true
        }
        
        //Check current text
        guard let currentText = textField.text else {
            return true
        }
        
        //Check range for the replacement string
        guard let range = Range(range, in: currentText) else {
            return true
        }
        
        //Remove the autocompletion bit from the text in order to use it for matching
        var newText = currentText.replacingCharacters(in: range, with: string).lowercased().capitalized
        newText.removeLast(currentText.count - range.upperBound.encodedOffset)
        
        //Check if there's any suggestion available in the array of cities
        guard var suggestion = cities.getMatch(for: newText) else {
            DispatchQueue.main.async {
                textField.text = newText
            }
            return true
        }
        
        //Remove the unused bit of the suggestion text
        suggestion.removeFirst(newText.count)
            
        DispatchQueue.main.async {
            textField.setAutocompleteAttributedText(text: newText,
                                                    suggestion: suggestion,
                                                    suggestionColor: Color.mainColor.color())
            textField.moveCaret(to: newText.count)
        }
        
        return true
    }
}
