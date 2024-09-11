//
//  LocationPinDetailViewController.swift
//  Map
//
//  Created by Mahsa on 9/11/24.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let saveButton = UIButton(type: .system)
    
    
    var locationTitle: String?
    var locationDescription: String?
    
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
    
    @objc private func saveButtonTapped(_sender : UIButton){
        
    }
    
    
    func saveLocationToFavorites(location: SearchResult) {
        let defaults = UserDefaults.standard
        
        if let savedLocations = defaults.object(forKey: "favoriteLocations") as? Data {
            var locations = try? JSONDecoder().decode([SearchResult].self, from: savedLocations)
            locations?.append(location)
            if let encodedLocations = try? JSONEncoder().encode(locations) {
                defaults.set(encodedLocations, forKey: "favoriteLocations")
            }
        } else {
            if let encodedLocation = try? JSONEncoder().encode([location]) {
                defaults.set(encodedLocation, forKey: "favoriteLocations")
            }
        }
        
    }
    
    private func setupUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
                
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
                
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
