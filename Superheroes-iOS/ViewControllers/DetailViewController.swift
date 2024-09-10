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
    
    @IBOutlet weak var intelligenceProgressView: UIProgressView!
    
    
    @IBOutlet weak var raceLabel: UILabel!
    

    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var genderIconsView: UIImageView!
    
    @IBOutlet weak var baseTextView: UITextView!
    
    var superHero: SuperHero? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.roundCorners(radius: 8)

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
            intelligenceProgressView.progress = (Float((superHero.powerstats.intelligence)!) ?? 0.0) / 100.0
            raceLabel.text = superHero.appearance.race
            baseTextView.text = superHero.work.base
            genderLabel.text = superHero.appearance.gender
            
            if (genderLabel.text == "Male") {
                genderIconsView.image = UIImage(named: "gender-icons/male")
            } else if (genderLabel.text == "Female") {
                genderIconsView.image = UIImage(named: "gender-icons/female")
            } else {
                genderIconsView.image = UIImage(named: "gender-icons/both")
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
