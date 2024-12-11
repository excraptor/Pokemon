//
//  PokemonListViewModel.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import Foundation
import Combine
import SwiftUI

class PokemonListViewModel: ObservableObject {
    
    public let pokemonDatasource: PokemonDatasource
    public let networkMonitor: NetworkMonitor
    
    @Published var pokemons: [PokemonModel] = []
    
    init(pokemonDatasource: PokemonDatasource, networkMonitor: NetworkMonitor) {
        self.pokemonDatasource = pokemonDatasource
        self.networkMonitor = networkMonitor
        
        pokemonDatasource.$pokemons
            .receive(on: DispatchQueue.main)
            .assign(to: &$pokemons)
    }
    
    func fetchPokemons() async {
        await pokemonDatasource.fetchPokemons()
    }
    
    func hasMorePokemons() -> Bool {
        pokemonDatasource.pokemons.count < pokemonDatasource.maxCount ?? -1
    }
    
    var contentAvailable: Bool {
        !pokemonDatasource.pokemons.isEmpty || networkMonitor.status == .connected
    }
}
