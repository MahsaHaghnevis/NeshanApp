//
//  LocationPinDetailViewController.swift
//  Map
//
//  Created by Mahsa on 9/11/24.
//

import UIKit

class LocationPinDetailViewController: UIViewController {

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
        
    }
    
}
