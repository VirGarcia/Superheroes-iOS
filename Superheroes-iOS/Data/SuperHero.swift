//
//  Superhero.swift
//  Superheroes-iOS
//
//  Created by Mañanas on 4/9/24.
//

import Foundation
import UIKit

struct SuperHeroResponse: Codable {
    let response: String
    let results: [SuperHero]
}

struct SuperHero: Codable {
    let id: String
    let name: String
    let image: Image
}

struct Image: Codable {
    let url: String
}




