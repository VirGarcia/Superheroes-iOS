//
//  DetailViewController.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 5/9/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    @IBOutlet weak var alignmentLabel: UILabel!
    
    var superHero: SuperHero? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let superHero = superHero {
            self.navigationItem.title = superHero.name
            avatarImageView.loadFrom(url: superHero.image.url)
            
            realNameLabel.text = superHero.biography.realName
            publisherLabel.text = superHero.biography.publisher
            placeOfBirthLabel.text = superHero.biography.placeOfBirth
            alignmentLabel.text = superHero.biography.alignment.uppercased()
            if (superHero.biography.alignment == "good") {
                alignmentLabel.textColor = UIColor.systemGreen
            } else {
                alignmentLabel.textColor = UIColor.systemRed
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
