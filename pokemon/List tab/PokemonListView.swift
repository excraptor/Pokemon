//
//  PokemonListView.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    var body: some View {
        if viewModel.contentAvailable {
            PokemonsList()
        } else {
            NetworkUnavailableView()
        }
    }
    
    @ViewBuilder
    func PokemonsList() -> some View {
        NavigationStack {
            List {
                ForEach(viewModel.pokemons, id: \.name) { pokemon in
                    NavigationLink(pokemon.name) {
                        PokemonDetailsLoaderView(viewModel: PokemonDetailsViewModel(pokemon: pokemon, pokemonDatasource: viewModel.pokemonDatasource, networkMonitor: viewModel.networkMonitor))
                    }
                }
                
                if viewModel.hasMorePokemons() {
                    HStack {
                        Spacer()
                        ProgressView()
                            .onAppear(perform: {
                                Task { @MainActor in
                                    await viewModel.fetchPokemons()
                                }
                            })
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
        }
        .onAppear(perform: {
            Task { @MainActor in
                await viewModel.fetchPokemons()
            }
        })
    }
}
