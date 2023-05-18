//
//  PokemonStatusBadge.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import SwiftUI

struct PokemonStatusBadge: View {
    let owned: Bool
    
    var body: some View {
        if owned {
            Image(AssetImages.PokeballIconEnabled)
                .resizable()
                .scaledToFit()
        }
        else {
            Image(AssetImages.PokeballIconDisabled)
                .resizable()
                .scaledToFit()
                .opacity(0.3)
        }
    }
}

struct PokemonStatusBadge_Previews: PreviewProvider {
    static var previews: some View {
        PokemonStatusBadge(owned: true)
            .frame(width: 60, height: 60)
    }
}
