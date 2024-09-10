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
    let locationButton = UIButton(type: .system)
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
        view.addSubview(buttonsStak)
        setupUI()
        
    }
    
    private func setupUI(){
        setupMap()
        setupStack()
        setupSearchButton()
        setupLocateButton()
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
    
    private func setupStack(){
        buttonsStak.axis = .horizontal
        buttonsStak.distribution = .fillEqually
        buttonsStak.alignment = .leading
        buttonsStak.spacing = 30
        buttonsStak.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    buttonsStak.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                    buttonsStak.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                    buttonsStak.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                    buttonsStak.heightAnchor.constraint(equalToConstant: 50)
                ])
        
        
        buttonsStak.addArrangedSubview(searchButton)
        buttonsStak.addArrangedSubview(locationButton)
    }
    
    private func setupSearchButton(){
        
        searchButton.setTitle("Search", for: .normal)
        
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 16
        
        //searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func setupLocateButton(){
        
        locationButton.setTitle("Locate", for: .normal)
        locationButton.backgroundColor = .systemGreen
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.clipsToBounds = true
        locationButton.layer.cornerRadius = 16
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


