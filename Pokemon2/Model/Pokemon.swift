//
//  Pokemon.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/11/22.
//

import Foundation
struct Pokemon: Codable {
    let attack, defense: Int
    let welcomeDescription: String
    let evolutionChain: [EvolutionChain]?
    let height, id: Int
    let imageURL: String
    let name, type: String
    let weight: Int
    let welcomeDefense: Int?

    enum CodingKeys: String, CodingKey {
        case attack, defense
        case welcomeDescription = "description"
        case evolutionChain, height, id
        case imageURL = "imageUrl"
        case name, type, weight
        case welcomeDefense = "defense:"
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let id, name: String
}
