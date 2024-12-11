//
//  PokemonDatasource.swift
//  pokemon
//
//  Created by Tamás Balla on 2024. 12. 09..
//
import Foundation
import SwiftUI

class PokemonDatasource {
    
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private let imagesBaseURL: URL = URL(string: "https://raw.githubusercontent.com/PokeApi/sprites/master/sprites/pokemon")!
    private var nextURL: URL?
    
    
    public var maxCount: Int?
    
    @Published public var pokemons: [PokemonModel] = []
    private var detailsCache = OfflineCache<PokemonModel, PokemonDetailModel>()
    
    func fetchPokemons() async {
        
        // If we have already fetched all items, we don't need to make the API call
        guard pokemons.isEmpty || maxCount ?? 0 > pokemons.count else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: nextURL ?? baseURL)
            let pokemonList = try JSONDecoder().decode(PokemonListModel.self, from: data)
            nextURL = pokemonList.next
            maxCount = pokemonList.count
            pokemons += pokemonList.results
        } catch {
            
            // Log error etc.
            return
        }
    }
    
    func fetchDetails(for pokemon: PokemonModel) async -> PokemonDetailModel? {
        guard detailsCache[pokemon] == nil else {
            print("[PokemonDatasource] Served \(pokemon.name) from cache")
            return detailsCache[pokemon]
        }
        var details = await fetchPokemonDetails(for: pokemon)
        guard let id = details?.id else { return details }
        
        let imageData = await fetchImageData(for: id)
        details?.imageData = imageData
        detailsCache[pokemon] = details
        return details
    }
    
    private func fetchPokemonDetails(for pokemon: PokemonModel) async -> PokemonDetailModel? {
        do {
            let (data, _) = try await URLSession.shared.data(from: pokemon.detailsUrl)
            return try JSONDecoder().decode(PokemonDetailModel.self, from: data)
        } catch {
            
            // Log error etc.
            return nil
        }
    }
    
    private func fetchImageData(for pokemonID: Int) async -> Data? {
        do {
            let imageURL = imagesBaseURL.appendingPathComponent("\(pokemonID).png")
            let (data, _) = try await URLSession.shared.data(from: imageURL)
            return data
            
        } catch {
            
            // Log error etc.
            return nil
        }
    }
}
