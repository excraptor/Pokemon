//
//  PokemonDetailsViewModel.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 10..
//

import Foundation
import Combine
import SwiftUI


class PokemonDetailsViewModel: ObservableObject {
    
    @Published var details: PokemonDetailModel?
    
    private let pokemon: PokemonModel
    private let pokemonDatasource: PokemonDatasource
    private let networkMonitor: NetworkMonitor
    
    init(pokemon: PokemonModel, pokemonDatasource: PokemonDatasource, networkMonitor: NetworkMonitor) {
        self.pokemon = pokemon
        self.pokemonDatasource = pokemonDatasource
        self.networkMonitor = networkMonitor
    }
    
    func update() {
        Task { @MainActor in
            self.details = await pokemonDatasource.fetchDetails(for: pokemon)
        }
    }
    
    var contentAvailable: Bool {
        details != nil || networkMonitor.status == .connected
    }
}
