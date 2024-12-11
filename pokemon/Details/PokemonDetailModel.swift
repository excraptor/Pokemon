//
//  PokemonDetailModel.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import Foundation
import SwiftUI

struct PokemonDetailModel: Codable, Hashable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let species: PokemonSpeciesModel
    var imageData: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case weight
        case species
        case imageData
    }
}

struct PokemonSpeciesModel: Codable, Hashable {
    let name: String
    let url: URL
}
