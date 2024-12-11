//
//  PokemonDetailsView.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 10..
//

import SwiftUI

struct PokemonDetailsLoaderView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel
    var body: some View {
        VStack {
            if let pokemon = viewModel.details {
                PokemonDetailsView(pokemon: pokemon)
            } else if viewModel.contentAvailable {
                VStack {
                    ProgressView()
                    Text("Loading...")
                }
            } else {
                NetworkUnavailableView()
            }
        }
        .onAppear {
            viewModel.update()
        }
    }
}

struct PokemonDetailsView: View {
    let pokemon: PokemonDetailModel
    let PokemonImage: Image?
    @Environment(FavoritePokemons.self) var favorites
    
    init(pokemon: PokemonDetailModel) {
        self.pokemon = pokemon
        if let imageData = pokemon.imageData {
            self.PokemonImage = Image(uiImage: UIImage(data: imageData)!)
        } else {
            self.PokemonImage = nil
        }
    }
    
    var body: some View {
        VStack {
            if let PokemonImage {
                PokemonImage
            }
            
            Group {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(pokemon.name)
                }
                HStack {
                    Text("Base experience:")
                    Spacer()
                    Text("\(pokemon.baseExperience)")
                }
                HStack {
                    Text("Height, weight:")
                    Spacer()
                    Text("\(pokemon.height), \(pokemon.weight)")
                }
                HStack {
                    Text("Species:")
                    Spacer()
                    Text(pokemon.species.name)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .navigationTitle(pokemon.name)
        .toolbar {
            Button {
                favorites.toggleFavorite(for: pokemon)
            } label: {
                Image(systemName: favorites.contains(pokemon) ? "heart.fill" : "heart")
            }
            if let PokemonImage {
                ShareLink(item: PokemonImage, preview: SharePreview("Share image for \(pokemon.name)", image: PokemonImage))
            }
        }
    }
}
