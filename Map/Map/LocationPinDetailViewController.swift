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
        
     var locationTitle: String?
     var locationDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
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
   
}
