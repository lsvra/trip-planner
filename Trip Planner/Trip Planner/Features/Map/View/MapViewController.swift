//
//  MapViewController.swift
//  Trip Planner
//
//  Created by Luís Vieira on 03/01/2019.
//  Copyright © 2019 lsvra. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: Static init vars
    private static let storyboardName = "Features"
    private static let identifier = "MapViewController"
    
    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: Vars
    var viewModel: MapViewModel?
    
    //Mark: Static init
    static func instantiate(with params: MapParams) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: MapViewController.storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: MapViewController.identifier)
        
        guard let mapViewController = viewController as? MapViewController else {
           return nil
        }
        
        mapViewController.viewModel = MapViewModel(coordinates: params.coordinates)
        
        return viewController
    }
    
    //MARK: Lifecycle
    override func loadView() {
        super.loadView()
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindOperations()
        
        if let viewModel = viewModel {
            viewModel.requestAnnotations()
            viewModel.requestPathBetweenAnnotations()
        }
    }
    
    //MARK: Methods
    private func configureView(){
        mapView.layoutMargins = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        mapView.delegate = self
    }
    
    private func bindOperations(){
        
        guard let viewModel = viewModel else {
            
            let error = MapError.unknownError
            displayError(title: error.title().localized(), message: error.message().localized())
            return
        }
        
        viewModel.displayAnnotations = { [weak self] annotations in
            
            guard let self = self else {
                return
            }
            
            guard let mapView = self.mapView else {
                let error = MapError.drawingError
                self.displayError(title: error.title().localized(), message: error.message().localized())
                return
            }
            
            mapView.showAnnotations(annotations, animated: true)
        }
        
        viewModel.displayPath = { [weak self] path in
            
            guard let self = self else {
                return
            }
            
            guard let mapView = self.mapView else {
                let error = MapError.drawingError
                self.displayError(title: error.title().localized(), message: error.message().localized())
                return
            }
            
            mapView.addOverlay(path)
        }
    }
}
