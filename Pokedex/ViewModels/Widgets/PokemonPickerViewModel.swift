//
//  PokemonPickerViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import Foundation

class PokemonPickerViewModel: ObservableObject {
    @Published var searchTerm = ""
    weak var delegate: PokemonPickerDelegate?
    
    var selectedSpecies:PokemonSpecies? {
        if(searchTerm.isEmpty) {
            return nil
        }
        
        let searchResults = PokemonSpecies.searchByName(searchTerm)
        return searchResults.first
    }
    
    func reset() {
        searchTerm = ""
    }
    
    func confirmSelection() {
        delegate?.didSelectPokemonSpecies(selectedSpecies)
    }
}

protocol PokemonPickerDelegate: AnyObject {
    func didSelectPokemonSpecies(_ species: PokemonSpecies?)
}
