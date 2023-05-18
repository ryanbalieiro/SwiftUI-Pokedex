//
//  OwnedTabViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import Foundation

class OwnedTabViewModel:ObservableObject, PokemonPickerDelegate {
    @Published var listSearchTerm = ""
    @Published var showRegisterMenu = false
    
    @Published var showErrorMessage = false
    @Published var errorMessage = ""
    
    
    func getFilterResults(_ pokemonList:[PokemonEntity]) -> [PokemonEntity] {
        let searchTerm = listSearchTerm.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !searchTerm.isEmpty else {
            return pokemonList
        }
        
        let filteredList = pokemonList.filter { pokemonEntity in
            if let species = PokemonSpecies.fromId(pokemonEntity.speciesId) {
                return species.name.lowercased().contains(searchTerm)
            } else {
                return false
            }
        }
        
        return filteredList
    }
    
    func didSelectPokemonSpecies(_ species: PokemonSpecies?) {
        var success = false
        if let species = species {
            success = CoreDataManager.shared.addPokemon(speciesId: species.id)
        }
        
        if(!success) {
            displayErrorMessage(message: "owned_tab_error_adding".localized())
        }
        
        showRegisterMenu = false
    }
    
    func deletePokemon(pokemonEntity:PokemonEntity) {
        let success = CoreDataManager.shared.deletePokemon(pokemonEntity: pokemonEntity)
        if(!success) {
            displayErrorMessage(message: "owned_tab_error_deleting".localized())
        }
    }
    
    private func displayErrorMessage(message:String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showErrorMessage = true
            self.errorMessage = message
        }
    }
}
