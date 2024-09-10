//
//  HomeViewController.swift
//  Map
//
//  Created by Mahsa on 9/10/24.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController  {
    
    let mapView = MKMapView()
    let searchButton = UIButton(type: .system)
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        view.addSubview(mapView)
        
        setupUI()
        
    }
    
    private func setupUI(){
        setupMap()
    }
    
    private func setupMap(){
        
        mapView.frame = view.bounds
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor) ,
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ])
        
        
    }
    
    
    
}


