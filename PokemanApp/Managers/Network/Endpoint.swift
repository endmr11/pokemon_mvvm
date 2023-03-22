//
//  Endpoint.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

enum Endpoint {
    enum Constant {
        static let baseURL = "https://pokeapi.co/api/v2/pokemon"
    }
    case pokemonSearchName(pokemonSearchName: String)
    var url: String {
        switch self {
        case .pokemonSearchName(let pokemonSearchName):
            return "\(Constant.baseURL)/\(pokemonSearchName)"
        }
    }
}
