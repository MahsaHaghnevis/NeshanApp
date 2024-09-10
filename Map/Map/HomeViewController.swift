//
//  HomeViewController.swift
//  Map
//
//  Created by Mahsa on 9/10/24.
//

import UIKit
import MapKit


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
        
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
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
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        searchButton.backgroundColor = .systemBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 16
        
        //searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func setupLocateButton(){
        
        locationButton.setTitle("Locate", for: .normal)
        locationButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        locationButton.backgroundColor = .systemGreen
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.clipsToBounds = true
        locationButton.layer.cornerRadius = 16
    }
    
    @objc func locationButtonTapped() {
        if let userLocation = locationManager.location?.coordinate {
            print("User location: \(userLocation.latitude), \(userLocation.longitude)")
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        } else {
            showLocationAccessAlert(title: "Location Access Denied", message: "عدم دسترسی به موقعیت مکانی شما . لطفا در تنظیمات تغییر دهید")
        }
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            showLocationAccessAlert(title: "Location Access Denied", message: "عدم دسترسی به موقعیت مکانی شما . لطفا در تنظیمات تغییر دهید")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            showLocationAccessAlert(title: "Unknown Status", message: "مشکل فنی در دریافت لوکیشن رخ داده است")
        }
    }
    
    
    private func showLocationAccessAlert(title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if title == "Location Access Denied" {
                alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                })
            }
        self.present(alert, animated: true, completion: nil)
    }
}


