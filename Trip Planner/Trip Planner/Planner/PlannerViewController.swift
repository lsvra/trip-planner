//
//  ViewController.swift
//  Trip Planner
//
//  Created by Luís Vieira on 30/12/2018.
//  Copyright © 2018 lsvra. All rights reserved.
//

import UIKit

class PlannerViewController: UIViewController {
    
    //MARK: Vars
    var viewModel: PlannerViewModel?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PlannerViewModel(session: Configurator.session(),
                                     queue: Configurator.queue(),
                                     reachability: Configurator.reachability())
        
        bindOperations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel {
            viewModel.requestConnections()
        }
    }
    
    //MARK: Methods
    private func bindOperations(){
        
        guard let viewModel = viewModel else {
            
            let error = ConnectionsError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        viewModel.reload = { connections in
            //TODO: Reload Connections
            print(connections)
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

