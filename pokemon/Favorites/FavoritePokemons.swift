//
//  FavoritePokemons.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 10..
//

import Foundation
import SwiftUI
import Combine

@Observable
class FavoritePokemons {
    // the actual resorts the user has favorited
    public var favorites: [PokemonDetailModel]

    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"

    init() {
        // load our saved data
        if let data = UserDefaults.standard.object(forKey: key) as? Data,
           let favorites = try? JSONDecoder().decode([PokemonDetailModel].self, from: data) {
            self.favorites = favorites
        } else {
            favorites = []
        }
    }

    // returns true if our set contains this resort
    func contains(_ pokemon: PokemonDetailModel) -> Bool {
        favorites.contains(pokemon)
    }

    // adds the resort to our set and saves the change
    func add(_ pokemon: PokemonDetailModel) {
        guard !contains(pokemon) else { return }
        favorites.append(pokemon)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ pokemon: PokemonDetailModel) {
        favorites.removeAll { $0 == pokemon }
        save()
    }
    
    func toggleFavorite(for pokemon: PokemonDetailModel) {
        favorites.contains(pokemon) ? remove(pokemon) : add(pokemon)
    }

    func save() {
        // write out our data
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
