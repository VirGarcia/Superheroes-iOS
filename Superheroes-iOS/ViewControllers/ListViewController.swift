//
//  ViewController.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 3/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{
    
    // MARK: TableView Delegate & DataSource

    @IBOutlet weak var tableView: UITableView!
    
    
    var superHeroList: [SuperHero] = []
    //var superheroInitialList: [SuperHero] = []
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup searchBar
        let search = UISearchController(searchResultsController: nil)
        //search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        
        //Setup tableView
        tableView.dataSource = self
        
        // Search data
               searchSuperHeroes("a")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superHeroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SuperHeroViewCell
        
        let superHero = superHeroList[indexPath.row]
        
        cell.render(superHero: superHero)
        
        return cell
    }
    
    // MARK: SearchBar Delegate
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchSuperHeroes(searchBar.text!)
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchSuperHeroes("a")
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if (searchText.isEmpty) {
                searchSuperHeroes("a")
            }
        }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let viewController = segue.destination as! DetailViewController
            
            let indexPath = tableView.indexPathForSelectedRow!
            
            viewController.superHero = superHeroList[indexPath.row]
            
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    // MARK: Buisness Logic
    func searchSuperHeroes(_ query: String) {
        /*SuperHeroProvider.findSuperHeroesByName(query, withResult: { [unowned self] results in
         self.superHeroList = results
         DispatchQueue.main.async {
         self.tableView.reloadData()
         }
         })*/
        
        Task {
            let results = try? await SuperHeroProvider.findSuperHeroesByName(query)
            if let results = results {
                self.superHeroList = results
            } else {
                self.superHeroList = []
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    // MARK: Pull to refresh
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
       // Update your content…
        SuperHeroProvider.findSuperHeroesByName("a", withResult: { [weak self] results in
            self?.superHeroList = results
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                // Dismiss the refresh control.
                self?.tableView.refreshControl?.endRefreshing()
            }
        })
    }

}


