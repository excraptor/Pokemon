//
//  PokemonModel.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import Foundation

struct PokemonModel: Codable, Hashable {
    let name: String
    let detailsUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case name
        case detailsUrl = "url"
    }
}
