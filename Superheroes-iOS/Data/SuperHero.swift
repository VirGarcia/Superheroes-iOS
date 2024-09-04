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
    let powerstats: Stats
    let biography:Biography
    //let work:Work
    var image: Image
}

struct Image: Codable {
    let url: String
}

struct Biography: Codable {
    let publisher: String
}

struct Stats: Codable {
    let intelligence: String?
    let strength: String?
    let speed: String?
    let durability: String?
    let power: String?
    let combat: String?
}
