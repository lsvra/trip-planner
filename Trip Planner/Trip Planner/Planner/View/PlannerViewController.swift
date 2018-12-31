//
//  ViewController.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

class PlannerViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var goToMapButton: UIButton!
    
    //MARK: Vars
    var viewModel: PlannerViewModel?
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PlannerViewModel(session: Configurator.session(),
                                     queue: Configurator.queue(),
                                     reachability: Configurator.reachability())
        
        hideKeyboardOnTap()
        bindOperations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel {
            viewModel.requestConnections()
        }
    }
    
    //MARK: Methods
    @IBAction func goToMapButtonTapped(_ sender: UIButton) {
        //TODO: Open map
    }
    
    private func configureView(){
        goToMapButton.backgroundColor = Color.mainColorDark.color()
        goToMapButton.setTitleColor(Color.white.color() , for: .normal)
        goToMapButton.setTitleColor(Color.secondaryColor.color(), for: .disabled)
        goToMapButton.isEnabled = false
        
        goToMapButton.setTitle("button_go_to_map".localized(), for: .normal)
        goToMapButton.titleLabel?.font = UIFont(name: Font.regular.name(), size: 16)
        
        costLabel.font = UIFont(name: Font.bold.name(), size: 34)
        costLabel.textColor = Color.mainColorDark.color()
        costLabel.text = "0"
        
        fromTextField.font = UIFont(name: Font.regular.name(), size: 16)
        fromTextField.placeholder = "texfield_placeholder_from".localized()
        fromTextField.clearButtonMode = .whileEditing
        fromTextField.returnKeyType = .done
        fromTextField.delegate = self
        
        toTextField.font = UIFont(name: Font.regular.name(), size: 16)
        toTextField.placeholder = "texfield_placeholder_to".localized()
        toTextField.clearButtonMode = .whileEditing
        toTextField.returnKeyType = .done
        toTextField.delegate = self
    }
    
    private func bindOperations(){
        
        guard let viewModel = viewModel else {
            
            let error = ConnectionsError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        viewModel.reload = { connections in
            //TODO: Reload Connections
        }
        
        viewModel.displayError = { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            self.displayError(title: error.title().localized(), message: error.message().localized())
        }
    }
    
    private func displayError(title: String, message: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error_action_ok".localized(),
                                      style: .default,
                                      handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

