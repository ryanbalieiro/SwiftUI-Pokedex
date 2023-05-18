//
//  CatalogViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import Foundation

class CatalogTabViewModel:ObservableObject {
    @Published var searchInput:String = ""
    
    var filteredResults:[PokemonSpecies] {
        return PokemonSpecies.searchByName(searchInput)
    }
}
