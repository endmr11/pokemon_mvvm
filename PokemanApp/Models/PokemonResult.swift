//
//  PokemonResult.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

// MARK: - PokemonResult
struct PokemonResult: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String?
    let url: String?
    var imgUrl: String?
    var detail: PokemonDetailResult?
}



