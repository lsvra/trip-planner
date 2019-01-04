//
//  ViewController.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

class PlannerViewController: UIViewController {
    
    //MARK: Static init vars
    private static let storyboardName = "Features"
    private static let identifier = "PlannerViewController"
    
    //MARK: IBOutlets
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var planTripButton: UIButton!
    @IBOutlet weak var goToMapButton: UIButton!
    
    //MARK: Vars
    private var viewModel: PlannerViewModel?
    var availableCities: Set<String>?
    
    //Mark: Static init
    static func instantiate(with params: PlannerParams) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: PlannerViewController.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: PlannerViewController.identifier)
        
        guard let plannerViewController = viewController as? PlannerViewController else {
            return nil
        }
        
        plannerViewController.viewModel = PlannerViewModel(session: params.session(),
                                                           queue: params.queue(),
                                                           reachability: params.reachability())
    
        return viewController
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        openMap()
    }
    
    private func configureView(){
        
        //This can be made in the storyboard. I prefer coding my way through it.
        //The class grows a bit more but we also have more control over the layout.
        
        if let navigationController = navigationController {
            navigationController.navigationBar.tintColor = Color.mainColorDark.color()
            navigationController.navigationBar.topItem?.title = "app_name".localized()
        }
      
        goToMapButton.setTitle("button_go_to_map".localized(), for: .normal)
        goToMapButton.titleLabel?.font = UIFont(name: Font.regular.name(), size: 16)
        goToMapButton.backgroundColor = Color.gray.color()
        goToMapButton.setTitleColor(Color.white.color() , for: .normal)
        goToMapButton.setTitleColor(Color.white.color(), for: .disabled)
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
        fromTextField.autocorrectionType = .no
        fromTextField.delegate = self
        
        toTextField.font = UIFont(name: Font.regular.name(), size: 16)
        toTextField.placeholder = "texfield_placeholder_to".localized()
        toTextField.textColor = Color.textColorDark.color()
        toTextField.clearButtonMode = .whileEditing
        toTextField.returnKeyType = .done
        toTextField.autocorrectionType = .no
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
                self.goToMapButton.backgroundColor = isEnabled ? Color.mainColorDark.color() : Color.gray.color()
            }
        }
    }
    
    private func planTrip(){
        
        guard let start = fromTextField.text, let end = toTextField.text else {
            
            let error = PlannerError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        guard !start.isEmpty,!end.isEmpty else {
            
            let error = PlannerError.emptyFields
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        if let viewModel = viewModel {
            viewModel.requestPathAndCost(from: start, to: end)
        }
    }
    
    private func openMap(){
        
        guard let navigationController = navigationController else {
            
            let error = PlannerError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        guard let coordinates = viewModel?.coordinates else {
            
            let error = PlannerError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        let params = MapParams(coordinates: coordinates)
        
        guard let viewController = MapViewController.instantiate(with: params) else {
            
            let error = PlannerError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
