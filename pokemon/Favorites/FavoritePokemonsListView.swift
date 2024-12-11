//
//  FavoritePokemonsListView.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 10..
//

import SwiftUI

struct FavoritePokemonsListView: View {
    @Environment(FavoritePokemons.self) var favorites
    
    var body: some View {
        NavigationStack {
            List(favorites.favorites, id: \.id) { pokemon in
                    NavigationLink {
                        PokemonDetailsView(pokemon: pokemon)
                    } label: {
                        HStack {
                            if let imageData = pokemon.imageData {
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                            }
                            Text(pokemon.name)
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(.plain)
    }
}

