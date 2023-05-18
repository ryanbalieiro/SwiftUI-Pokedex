//
//  DataManager.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    private let container = NSPersistentContainer(name: "Pokedex")
    private var didLoadPersistentStores = false
    
    @Published var pokemonList:[PokemonEntity] = []
    
    static let shared = CoreDataManager()
    
    private init() {
        container.loadPersistentStores() { desc, error in
            if(error == nil) {
                self.didLoadPersistentStores = true
                self.updatePokemonList()
            }
        }
    }
    
    func hasPokemon(species:PokemonSpecies) -> Bool {
        return pokemonList.contains(where: {
            $0.speciesId == species.id
        })
    }
    
    func addPokemon(speciesId:Int) -> Bool {
        let pokemon = PokemonEntity(context: container.viewContext)
        pokemon.speciesId = Int16(speciesId)
        pokemon.dateAdded = Date()
        return save(context: container.viewContext)
    }
    
    func evolvePokemon(pokemonEntity: PokemonEntity) -> Bool {
        let species = PokemonSpecies.fromId(pokemonEntity.speciesId)
        if let evolution = species?.getEvolution() {
            pokemonEntity.speciesId = Int16(evolution.id)
            return save(context: container.viewContext)
        }
        
        return false
    }
    
    func deletePokemon(pokemonEntity: PokemonEntity) -> Bool {
        container.viewContext.delete(pokemonEntity)
        return save(context: container.viewContext)
    }
    
    private func save(context:NSManagedObjectContext) -> Bool {
        if(!didLoadPersistentStores) {
            return false
        }
        
        do {
            try context.save()
            updatePokemonList()
            return true
        }
        catch {
            return false
        }
    }
    
    private func updatePokemonList() {
        let request:NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \PokemonEntity.dateAdded, ascending: false)
        ]
        
        do {
            let pokemonList = try container.viewContext.fetch(request)
            self.pokemonList = pokemonList
        }
        catch {
            self.pokemonList = []
        }
    }
}
