//
//  String+TextCase.swift
//  PokemanApp
//
//  Created by Eren Demir on 21.03.2023.
//

import Foundation

extension String {
    
    func lowerSnakeCased() -> String {
        return self.words.map({ $0.lowercased() }).joined(separator: "_")
    }

}
