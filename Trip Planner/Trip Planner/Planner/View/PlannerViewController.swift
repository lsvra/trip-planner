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
    @IBOutlet weak var planTripButton: UIButton!
    @IBOutlet weak var goToMapButton: UIButton!
    
    //MARK: Vars
    var viewModel: PlannerViewModel?
    var availableCities: Set<String>?
    
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
    
    @IBAction func planTripButtonTapped(_ sender: UIButton) {
        planTrip()
    }
    
    @IBAction func goToMapButtonTapped(_ sender: UIButton) {
        //TODO: Open map
    }
    
    private func configureView(){
        
        goToMapButton.setTitle("button_go_to_map".localized(), for: .normal)
        goToMapButton.titleLabel?.font = UIFont(name: Font.regular.name(), size: 16)
        goToMapButton.backgroundColor = Color.textColorRed.color()
        goToMapButton.setTitleColor(Color.white.color() , for: .normal)
        goToMapButton.setTitleColor(Color.secondaryColor.color(), for: .disabled)
        goToMapButton.isEnabled = false
        
        planTripButton.setTitle("button_plan_trip".localized(), for: .normal)
        planTripButton.titleLabel?.font = UIFont(name: Font.regular.name(), size: 16)
        planTripButton.backgroundColor = Color.mainColorDark.color()
        planTripButton.setTitleColor(Color.white.color() , for: .normal)
        
        costLabel.font = UIFont(name: Font.bold.name(), size: 34)
        costLabel.textColor = Color.mainColorDark.color()
        costLabel.text = "-"
        
        fromTextField.font = UIFont(name: Font.regular.name(), size: 16)
        fromTextField.placeholder = "texfield_placeholder_from".localized()
        fromTextField.textColor = Color.textColorDark.color()
        fromTextField.clearButtonMode = .whileEditing
        fromTextField.returnKeyType = .done
        fromTextField.delegate = self
        
        toTextField.font = UIFont(name: Font.regular.name(), size: 16)
        toTextField.placeholder = "texfield_placeholder_to".localized()
        toTextField.textColor = Color.textColorDark.color()
        toTextField.clearButtonMode = .whileEditing
        toTextField.returnKeyType = .done
        toTextField.delegate = self
    }
    
    private func bindOperations(){
        
        guard let viewModel = viewModel else {
            
            let error = PlannerError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        viewModel.reload = { cities in
            self.availableCities = cities
        }
        
        viewModel.displayError = { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            self.displayError(title: error.title().localized(), message: error.message().localized())
        }
        
        viewModel.displayCost = { [weak self] cost in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.costLabel.text = cost
            }
        }
        
        viewModel.toggleMapButton = { [weak self] isEnabled in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.goToMapButton.isEnabled = isEnabled
                self.goToMapButton.backgroundColor = isEnabled ? Color.mainColorDark.color() : Color.textColorRed.color()
            }
        }
    }
    
    private func planTrip(){
        
        guard let start = fromTextField.text, let end = toTextField.text else {
            return
        }
        
        if let viewModel = viewModel {
            viewModel.requestPathAndCost(from: start, to: end)
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
