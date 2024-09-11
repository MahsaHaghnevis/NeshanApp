//
//  SearchViewController.swift
//  Map
//
//  Created by Mahsa on 9/10/24.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    let searchTextField = UITextField()
    let tableView = UITableView()
    
    let showOnMapButton = UIButton(type: .system)
    
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    var searchResults: [SearchResult] = []
    
    var savedLocations: [SearchResult] = []
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupLocationManager()
        setupUI()
        loadSavedLocations()
    }
    
    private func loadSavedLocations() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.data(forKey: "favoriteLocations") {
            savedLocations = (try? JSONDecoder().decode([SearchResult].self, from: savedData)) ?? []
            tableView.reloadData()
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    private func setupUI(){
        
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        view.addSubview(showOnMapButton)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        
        setupSearchTextField()
        setupTableView()
        setupShowOnMapButton()
        
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
    
    
    
    private func setupShowOnMapButton() {
        showOnMapButton.setTitle("Show on Map", for: .normal)
        showOnMapButton.backgroundColor = .systemBlue
        showOnMapButton.setTitleColor(.white, for: .normal)
        showOnMapButton.layer.cornerRadius = 10
        showOnMapButton.translatesAutoresizingMaskIntoConstraints = false
        showOnMapButton.addTarget(self, action: #selector(showOnMapButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            showOnMapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            showOnMapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showOnMapButton.widthAnchor.constraint(equalToConstant: 150),
            showOnMapButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    var onShowOnMap: (([SearchResult]) -> Void)?
    
    @objc func showOnMapButtonTapped(){
        
        let locationsToShow = isTyping ? searchResults : savedLocations
        onShowOnMap?(locationsToShow)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func searchTextChanged(_ sender : Any){
        
        isTyping = !(searchTextField.text?.isEmpty ?? true)
        
        if isTyping {
            guard let query = searchTextField.text, !query.isEmpty else { return }
            fetchSearchResults(query: query)
        }else{
            tableView.reloadData()
        }
    }
    
    private func fetchSearchResults(query : String ){
        
        guard let userLocation = userLocation else {
            print("User location is not available")
            return
        }
        
        
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        let apiconf = APIconf()
        
        let urlString = "\(apiconf.baseURL)term=\(query)&lat=\(latitude)&lng=\(longitude)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest (url : url)
        request.addValue(apiconf.apiKey, forHTTPHeaderField: "Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                   guard let self = self, let data = data, error == nil else { return }

                   do {
                       let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                       self.searchResults = searchResponse.items

                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                       }
                   } catch {
                       print("Error parsing JSON: \(error)")
                   }
               }
               task.resume()
           }
        
    }

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTyping ? searchResults.count : savedLocations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        let data = isTyping ? searchResults[indexPath.row] : savedLocations[indexPath.row]
        cell.textLabel?.text = data.title
        cell.textLabel?.textAlignment = .right
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedLocation = isTyping ? searchResults[indexPath.row] : savedLocations[indexPath.row]
       // print(searchResults[indexPath.row].title)
        
        let detailVC = LocationDetailViewController()
        detailVC.locationTitle = selectedLocation.title
        detailVC.locationDescription = selectedLocation.address
        detailVC.location = selectedLocation
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
}

extension SearchViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                userLocation = location
            }
        }
}
