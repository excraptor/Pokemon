//
//  PokemonListModel.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import Foundation

struct PokemonListModel: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [PokemonModel]
}
