//
//  SearchViewController.swift
//  Map
//
//  Created by Mahsa on 9/10/24.
//

import UIKit

class SearchViewController: UIViewController {

    let searchTextField = UITextField()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    private func setupUI(){
        
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        setupSearchTextField()
        setupTableUI()
    }
    private func setupSearchTextField(){
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "مکان را جستجو کنید"
        searchTextField.borderStyle = .roundedRect
        searchTextField.clipsToBounds = true
        searchTextField.layer.cornerRadius = 10
        searchTextField.backgroundColor = .systemGray4
        searchTextField.textAlignment = .right
        
        NSLayoutConstraint.activate([
        
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 40) ,
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40) ,
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        
        ])
        
    }
    
    private func setupTableUI(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
                   tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
    }
    
    


}
