//
//  SuperHeroViewCell.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 4/9/24.
//

import UIKit
//esta cuando se crea hay que hacer que herede de cocoa

class SuperHeroViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    func render(superHero: SuperHero) {
        nameLabel.text = superHero.name
        avatarImageView.loadFrom(url: superHero.image.url)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.roundCorners(radius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    

}
