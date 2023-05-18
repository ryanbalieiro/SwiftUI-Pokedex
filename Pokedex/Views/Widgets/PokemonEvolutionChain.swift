//
//  PokemonEvolutionChain.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import SwiftUI

struct PokemonEvolutionChain: View {
    let species:PokemonSpecies
    
    var body: some View {
        HStack {
            /** Only display if there's at least 2 pokémon in the evolution chain, otherwise just display a feedback message.*/
            if species.evolutionChain.count >= 2 {
                Spacer()
                ForEach(0...species.evolutionChain.count - 1, id:\.self) { pokemonId in
                    /** Displays the chart for each pokémon on the chain. Just double checking to make sure it exists on the species array... */
                    if let species = PokemonSpecies.fromId(Int16(species.evolutionChain[pokemonId])) {
                        VStack {
                            PokemonAvatar(species: species, imageFrameSize: 60)
                            
                            Text(species.name.capitalized)
                                .fontWeight(.bold)
                                .font(.subheadline)
                                .padding(.top, 10)
                        }
                        .opacity(species == self.species ? 1 : 0.6)
                    }
                    
                    /** Adding the arrow on the right. if it's not the last one. */
                    if pokemonId < species.evolutionChain.count - 1 {
                        Spacer()
                        Image(systemName: "arrow.right")
                        Spacer()
                    }
                }
                Spacer()
            }
            else {
                Text("no_evolution_chain".localized())
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(AssetColors.Muted))
                    .fontWeight(.medium)
                    .padding(25)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct PokemonEvolutionChain_Previews: PreviewProvider {
    static var previews: some View {
        PokemonEvolutionChain(species: PokemonSpecies.allCases[0])
    }
}
