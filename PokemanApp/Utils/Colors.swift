//
//  Colors.swift
//  PokemanApp
//
//  Created by Eren Demir on 20.03.2023.
//

import Foundation

import UIKit

struct Color {
    static var white: UIColor {#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)}
    static var appBase: UIColor {#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)}
    static var pokemonCellBackgrounColor: UIColor {#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0.4906462585)}
    static var abilityCellBackgrounColor: UIColor {#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)}
    static var black: UIColor {#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
    static var gray: UIColor {.systemGray}
    static var abilityCellTextColor: UIColor{.systemOrange}
}
