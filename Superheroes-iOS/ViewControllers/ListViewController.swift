//
//  ViewController.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 3/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate{
    
    // MARK: TableView Delegate & DataSource

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var notFoundLabel: UILabel!
    
    var superHeroList: [SuperHero] = []
    //var superheroInitialList: [SuperHero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //configureRefreshControl()
        // Setup searchBar
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        //configureRefreshControl()
        
        //Setup tableView
        tableView.dataSource = self
        configureRefreshControl()
        
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
               DispatchQueue.main.async {
                   if let results = results {
                       self.superHeroList = results
                       self.notFoundLabel.isHidden = true // Oculta el label si hay resultados
                     
                   } else {
                       self.notFoundLabel.isHidden = false // Muestra el label si no hay resultados
                       self.notFoundLabel.text = "No hay resultados"
                       self.superHeroList = []
                     
                   }
                   self.tableView.reloadData()
                   // Dismiss the refresh control.
                   //
                   self.tableView.refreshControl?.endRefreshing()
               }
           }
       }
    
    
    // MARK: Pull to refresh
       func configureRefreshControl() {
          // Add the refresh control to your UIScrollView object.
           tableView.refreshControl = UIRefreshControl()
           tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
       }
           
       @objc func handleRefreshControl() {
           // Update your content…
           searchSuperHeroes("a")
       }
       
       // MARK: SearchBar Delegate
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchSuperHeroes(searchBar.text!)
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.notFoundLabel.isHidden = true
           searchSuperHeroes("a")
       }
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if (searchText.isEmpty) {
            searchSuperHeroes("a")
            }
        
        }
    
}


