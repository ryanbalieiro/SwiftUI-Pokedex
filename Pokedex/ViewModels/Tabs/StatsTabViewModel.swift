//
//  StatsTabViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 16/03/22.
//

import Foundation

class StatsTabViewModel:ObservableObject {
    @Published var totalOwnedStr:String = ""
    @Published var totalOwnedWithoutDuplicationsStr:String = ""
    
    @Published var totalSpeciesStr:String = ""
    @Published var percentageStr:String = ""
    
    @Published var versionStr:String = ""
    @Published var lastUpdateStr:String = ""
    
    func updateStats() {
        let totalSpecies = PokemonSpecies.allCases.count
        self.totalSpeciesStr = String(totalSpecies)
        
        let totalOwned = CoreDataManager.shared.pokemonList.count
        self.totalOwnedStr = String(totalOwned)
        
        var uniqueSpecies = Set<Int16>()
        for pokemonEntity in CoreDataManager.shared.pokemonList {
            uniqueSpecies.insert(pokemonEntity.speciesId)
        }
        let totalOwnedWithoutDiplications = uniqueSpecies.count
        self.totalOwnedWithoutDuplicationsStr = String(totalOwnedWithoutDiplications)
        
        let percentage = Double(totalOwnedWithoutDiplications)*100 / Double(totalSpecies)
        self.percentageStr = String(format: "%.2f", percentage) + "%"
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionStr = "v." + appVersion
        } else {
            self.versionStr = "???"
        }
        
        self.lastUpdateStr = BackendlessManager.shared.lastUpdate
    }
}
