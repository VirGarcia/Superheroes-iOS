//
//  ViewController.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 3/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    
    var superHeroList: [SuperHero] = []
    var superheroInitialList: [SuperHero] = []
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        /*SuperHeroProvider.findSuperHeroesByName("Super", withResult: { [unowned self] results in
            self.superHeroList = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })*/
        
        /*SuperheroProvider.searchByName(query: "a", completionHandler: { [weak self] results in
            self?.superheroInitialList = results
            self?.superheroList = results
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })*/
        
        let search = UISearchController(searchResultsController: nil)
        //search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        
        Task {
            let results = try? await SuperHeroProvider.findSuperHeroesByName("a")
            
            self.superHeroList = results!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    // MARK: SearchBar delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SuperHeroProvider.findSuperHeroesByName(searchBar.text!, withResult: { [weak self] results in
            self?.superHeroList = results
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.superHeroList = self.superheroInitialList
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty) {
            self.superHeroList = self.superheroInitialList
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let viewController = segue.destination as! DetailViewController
            
            let indexPath = tableView.indexPathForSelectedRow!
            
            viewController.superHero = superHeroList[indexPath.row]
            
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }

    
}


