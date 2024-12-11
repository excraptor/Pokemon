//
//  ContentView.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//

import SwiftUI

struct ContentView: View {
    @State var favorites = FavoritePokemons()
    @StateObject var networkMonitor = NetworkMonitor()
    let pokemonDatasource = PokemonDatasource()
    var body: some View {
        TabView {
            PokemonListView(viewModel: PokemonListViewModel(pokemonDatasource: pokemonDatasource, networkMonitor: networkMonitor))
                .tabItem {
                    Label {
                        Text("Pokemon")
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
            
            FavoritePokemonsListView()
                .tabItem {
                    Label {
                        Text("Favorites")
                    } icon: {
                        Image(systemName: "heart.fill")
                    }
                }
            
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
