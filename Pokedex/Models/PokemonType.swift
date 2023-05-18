//
//  PokemonType.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import Foundation

struct PokemonType: Codable, Identifiable {
    let name: String
    let systemImage: String
    
    var id: String {
        self.name.lowercased()
    }

    init(name:String, systemImage:String) {
        self.name = name
        self.systemImage = systemImage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)

        guard let type = PokemonType.allCases.first(where: { $0.name.lowercased() == string.lowercased() }) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid type: \(string)")
        }

        self = type
    }
    
    static func fromString(_ name: String) -> PokemonType {
        for type in PokemonType.allCases {
            if type.name.lowercased() == name.lowercased() {
                return type
            }
        }
        
        return allCases[0]
    }
}

extension PokemonType: CaseIterable {
    static var allCases: [PokemonType] = [
        PokemonType(name: "unknown", systemImage: "circle"),
        PokemonType(name: "normal", systemImage: "square.fill"),
        PokemonType(name: "fire", systemImage: "flame.fill"),
        PokemonType(name: "water", systemImage: "drop.fill"),
        PokemonType(name: "grass", systemImage: "leaf.fill"),
        PokemonType(name: "electric", systemImage: "bolt.fill"),
        PokemonType(name: "ice", systemImage: "cube.fill"),
        PokemonType(name: "fighting", systemImage: "figure.boxing"),
        PokemonType(name: "poison", systemImage: "syringe.fill"),
        PokemonType(name: "ground", systemImage: "globe.europe.africa.fill"),
        PokemonType(name: "flying", systemImage: "bird.fill"),
        PokemonType(name: "psychic", systemImage: "brain"),
        PokemonType(name: "bug", systemImage: "ant.fill"),
        PokemonType(name: "rock", systemImage: "mountain.2.fill"),
        PokemonType(name: "ghost", systemImage: "bubbles.and.sparkles.fill"),
        PokemonType(name: "dragon", systemImage: "fossil.shell.fill"),
        PokemonType(name: "dark", systemImage: "moon.fill"),
        PokemonType(name: "steel", systemImage: "wand.and.rays.inverse"),
        PokemonType(name: "fairy", systemImage: "sparkles")
    ]
}

extension PokemonType: Equatable {}

extension PokemonType: RawRepresentable {
    typealias RawValue = String

    init?(rawValue: RawValue) {
        guard let type = PokemonType.allCases.first(where: { $0.name == rawValue }) else {
            return nil
        }

        self = type
    }

    var rawValue: RawValue {
        name
    }
}
