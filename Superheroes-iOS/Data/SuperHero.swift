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
    let realName: String
    let placeOfBirth: String
    let publisher: String
    let alignment: String
    
    enum CodingKeys: String, CodingKey {
        case publisher, alignment
        case realName = "full-name"
        case placeOfBirth = "place-of-birth"
    }
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
}

struct Work: Codable {
    let base: String?
}

