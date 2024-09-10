import UIKit

// مدل داده برای نتیجه جستجو

class SearchViewController: UIViewController {

    let searchTextField = UITextField()
    let tableView = UITableView()
    
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        view.bringSubviewToFront(tableView)
        tableView.backgroundColor = .systemBlue
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "resultCell")
        
        setupSearchTextField()
        setupTableView()
    }
    
    private func setupSearchTextField() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.placeholder = "Search for places..."
        searchTextField.borderStyle = .roundedRect
        searchTextField.clipsToBounds = true
        searchTextField.layer.cornerRadius = 10
        searchTextField.backgroundColor = .systemGray4
        searchTextField.textAlignment = .left
        
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func searchTextChanged(_ sender: UITextField) {
        guard let query = searchTextField.text, !query.isEmpty else {
            searchResults.removeAll()
            tableView.reloadData()
            return
        }
        fetchSearchResults(query: query)
    }
    
    private func fetchSearchResults(query: String) {
        let urlString = "https://api.neshan.org/v1/search?term=\(query)&lat=35.6892&lng=51.3890"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("service.29a629cc9ebc4851958f7a9cefea43b0", forHTTPHeaderField: "Api-Key") // کلید API خود را وارد کنید
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let items = json["items"] as? [[String: Any]] {
                    
                    self.searchResults = items.compactMap { item in
                        guard let title = item["title"] as? String,
                              let address = item["address"] as? String,
                              let location = item["location"] as? [String: Double],
                              let longitude = location["x"],
                              let latitude = location["y"] else {
                            return nil
                        }
                        
                        return SearchResult(title: title, address: address, latitude: latitude, longitude: longitude)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        task.resume()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        let result = searchResults[indexPath.row]
        cell.textLabel?.text = result.title
        cell.detailTextLabel?.text = result.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(searchResults[indexPath.row].title)
    }
}
