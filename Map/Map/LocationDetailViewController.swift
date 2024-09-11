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
