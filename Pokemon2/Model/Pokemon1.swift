//
//  Pokemon1.swift
//  Pokemon2
//
//  Created by MacOne-YJ4KBJ on 3/12/22.
//

import Foundation

// MARK: - WelcomeElement
struct Pokemon1: Codable {
    let id: Int
    let name: Name
    let type: [String]
    let base: Base
}

// MARK: - Base
struct Base: Codable {
    let hp, attack, defense, spAttack: Int
    let spDefense, speed: Int

    enum CodingKeys: String, CodingKey {
        case hp = "HP"
        case attack = "Attack"
        case defense = "Defense"
        case spAttack = "Sp. Attack"
        case spDefense = "Sp. Defense"
        case speed = "Speed"
    }
}

// MARK: - Name
struct Name: Codable {
    let english, japanese, chinese, french: String
}

enum TypeElement: String, Codable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}

