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
    let powerstats: Powerstats
    let biography: Biography
    let appearance: Appearance
    let work: Work
}

struct Image: Codable {
    let url: String
}

struct Powerstats: Codable {
    let intelligence: String?
}

struct Biography: Codable {
    let fullName: String?
    let alignment: String?
    let publisher: String?
    
    enum CodingKeys: String, CodingKey {
        case alignment, publisher
        case fullName = "full-name"
    }
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
}

struct Work: Codable {
    let base: String?
}

