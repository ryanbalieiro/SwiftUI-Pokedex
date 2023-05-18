//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 09/03/22.
//

import Foundation

struct PokemonSpecies: Codable, Equatable, Identifiable {
    let id:Int
    let name:String
    let types:[PokemonType]
    let description:String
    let attack:Int
    let defense:Int
    let height:Double
    let weight:Double
    let evolutionChain:[Int]
    let slug:String
    
    static func fromId(_ id: Int16) -> PokemonSpecies? {
        return PokemonSpecies.allCases.first(where: {$0.id == id})
    }
    
    static func searchByName(_ name:String) -> [PokemonSpecies] {
        if name.isEmpty {
            return PokemonSpecies.allCases
        }
        
        let lowercasedName = name.lowercased()
        var results = PokemonSpecies.allCases.filter { $0.name.lowercased().contains(lowercasedName) }
        
        if let exactMatchIndex = results.firstIndex(where: { $0.name.lowercased() == lowercasedName }) {
            let exactMatch = results.remove(at: exactMatchIndex)
            results.insert(exactMatch, at: 0)
        }
        
        return results
    }
    
    func getEvolution() -> PokemonSpecies? {
        if evolutionChain.count < 2 || evolutionChain.last == self.id {
            return nil
        }
        
        if let index = evolutionChain.firstIndex(of: id) {
            let nextSpeciesId = evolutionChain[index + 1]
            return PokemonSpecies.fromId(Int16(nextSpeciesId))
        }
        
        return nil
    }
}

extension PokemonSpecies: CaseIterable {
    /** Init the allCases array with the samples for testing purposes... */
    static var allCases: [PokemonSpecies] = samples
    
    static let samples:[PokemonSpecies] = [
        PokemonSpecies(
            id: 1,
            name: "bulbasaur",
            types: [PokemonType.fromString("grass"), PokemonType.fromString("poison")],
            description: "A strange seed was planted on its back at birth. The plant sprouts and grows with this Pokémon.",
            attack: 49,
            defense: 49,
            height: 0.7,
            weight: 6.9,
            evolutionChain: [1,2,3],
            slug: "bulbasaur"
        ),
        
        PokemonSpecies(
            id: 2,
            name: "ivysaur",
            types: [PokemonType.fromString("grass"), PokemonType.fromString("poison")],
            description: "When the bulb on its back grows large, it appears to lose the ability to stand on its hind legs.",
            attack: 62,
            defense: 63,
            height: 1.0,
            weight: 13.0,
            evolutionChain: [1,2,3],
            slug: "ivysaur"
        ),
        
        PokemonSpecies(
            id: 3,
            name: "venusaur",
            types: [PokemonType.fromString("grass"), PokemonType.fromString("poison")],
            description: "Its plant blooms when it is absorbing solar energy. It stays on the move to seek sunlight.",
            attack: 82,
            defense: 83,
            height: 2.0,
            weight: 100.0,
            evolutionChain: [1,2,3],
            slug: "venusaur"
        )
    ]
}
