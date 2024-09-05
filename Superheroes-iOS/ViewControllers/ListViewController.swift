//
//  ViewController.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 3/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    var superHeroList: [SuperHero] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        SuperHeroProvider.findSuperHeroesByName("Super", withResult: { results in
            self.superHeroList = results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let viewController = segue.destination as! DetailViewController
            
            let indexPath = tableView.indexPathForSelectedRow!
            viewController.superHero = superHeroList[indexPath.row]
            
            tableView.deselectRow(at: indexPath, animated: false)
            
        }
    }

    
}


