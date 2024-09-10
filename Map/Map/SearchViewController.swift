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

    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    private func setupUI(){
        
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupSearchTextField()
        setupTableView()
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
        
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
    }
    
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                   tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
                   tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
    }
    
    @objc func searchTextChanged(_ sender : Any){
        guard let query = searchTextField.text, !query.isEmpty else { return }
        
        fetchSearchResults(query: query)
    }
    
    private func fetchSearchResults(query : String){
        
    }

}
extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = searchResults[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(searchResults[indexPath.row].title)
    }
    
    
}
