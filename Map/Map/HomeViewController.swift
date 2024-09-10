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
    let buttonsStak = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

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

extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        }
}


