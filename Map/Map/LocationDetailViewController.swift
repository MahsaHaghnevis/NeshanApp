//
//  LocationPinDetailViewController.swift
//  Map
//
//  Created by Mahsa on 9/11/24.
//

import UIKit
import MapKit

class LocationDetailViewController: UIViewController , CLLocationManagerDelegate {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let saveButton = UIButton(type: .system)
    
    var location: SearchResult?
    var locationTitle: String?
    var locationDescription: String?
    
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        updateUI()
        setUpButton()
    }
    private func setUpButton(){
        saveButton.setTitle("ذخیره", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            
        view.addSubview(saveButton)
            
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    @objc private func saveButtonTapped(_ sender: UIButton) {
        
        guard let location = location else {
                print("Error: Location is nil")
                return
            }
        
        print("Saving location: \(location.title), \(location.address), Coordinates: (\(location.location.x), \(location.location.y))")
        
        saveLocationToFavorites(location: location)
  
        
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "خطا", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveLocationToFavorites(location: SearchResult) {
        let defaults = UserDefaults.standard
        
        if let savedData = defaults.data(forKey: "favoriteLocations") {
            var savedLocations = (try? JSONDecoder().decode([SearchResult].self, from: savedData)) ?? []
            
            if savedLocations.contains(where: { $0.location.x == location.location.x && $0.location.y == location.location.y }) {
                showErrorAlert(message: "این مکان قبلاً ذخیره شده است.")
                return}
            
            savedLocations.append(location)
            
            if let encodedLocations = try? JSONEncoder().encode(savedLocations) {
                defaults.set(encodedLocations, forKey: "favoriteLocations")
                print("Location saved successfully.")
            } else {
                print("Error encoding locations.")
            }
        } else {
            if let encodedLocation = try? JSONEncoder().encode([location]) {
                defaults.set(encodedLocation, forKey: "favoriteLocations")
                print("First location saved successfully.")
            } else {
                print("Error encoding first location.")
            }
            
        }
        let alert = UIAlertController(title: "موفقیت", message: "مکان با موفقیت ذخیره شد.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    private func setupUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
                
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        NSLayoutConstraint.activate([
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
   
    private func updateUI() {
            titleLabel.text = locationTitle
            descriptionLabel.text = locationDescription
        }
}
