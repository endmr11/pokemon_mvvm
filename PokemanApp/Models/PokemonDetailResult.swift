//
//  PokemonDetailResult.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

struct PokemonDetailResult: Codable {
    let abilities: [Abilities]
    let base_experience: Int
    let forms: [Forms]
    let game_indices: [Game_Indices]
    let height: Int
    let id: Int
    let is_default: Bool
    let location_area_encounters: String
    let moves: [Moves]
    let name: String
    let sprites: Sprites
    let stats: [Stats]
    let types:[Tyypes]
    let weight: Int
    
}

struct Abilities: Codable{
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
    
}

struct Ability: Codable{
    let name: String
    let url: String
}

struct Forms: Codable{
    let name: String
    let url: String
}

struct Game_Indices: Codable{
    let game_index: Int
    let version: Version
}

struct Version: Codable{
    let name: String
    let url: String
}

struct Moves: Codable{
    let move: Move
}

struct Move: Codable{
    let name: String
    let url: String
}

struct Tyypes: Codable{
    let slot: Int
    let type: Tyype
}

struct Tyype: Codable{
    let name: String
    let url: String
}

struct Stats: Codable{
    let base_stat: Int
    let effort: Int
    let stat: Stat
}

struct Stat: Codable{
    let name: String
    let url: String
}

struct Sprites: Codable{
    let front_default: String
    let other: Other
}

struct Other: Codable{
    let home: Home
}

struct Home: Codable{
    let front_default: String
}
