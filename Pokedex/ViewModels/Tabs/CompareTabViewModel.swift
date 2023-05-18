//
//  CompareTabViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import Foundation

class CompareTabViewModel: ObservableObject, PokemonPickerDelegate {
    @Published var leftSpecies:PokemonSpecies = PokemonSpecies.allCases[0]
    @Published var rightSpecies:PokemonSpecies = PokemonSpecies.allCases[1]
    @Published var selectingSlot:Slot = .none
    @Published var showPokemonPicker = false
    
    func setSelectingSlot(slot:Slot) {
        selectingSlot = slot
        showPokemonPicker = true
    }
    
    func didSelectPokemonSpecies(_ species: PokemonSpecies?) {
        showPokemonPicker = false
        
        guard let species = species else {
            return
        }
        
        if(selectingSlot == .left) {
            leftSpecies = species
        }
        else if(selectingSlot == .right) {
            rightSpecies = species
        }
    }
    
    enum Slot {
        case left
        case right
        case none
    }
}
