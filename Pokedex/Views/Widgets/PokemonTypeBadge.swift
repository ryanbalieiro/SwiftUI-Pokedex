//
//  PokeTypeLabel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import SwiftUI

struct PokemonTypeBadge: View {
    let type:PokemonType?
    var sizeMultiplier:CGFloat = 1
    
    var body: some View {
        HStack {
            Image(systemName: type?.systemImage ?? "square")
                .frame(width: 24*sizeMultiplier, height:24*sizeMultiplier)
                .background(Color(type?.name.capitalized ?? AssetColors.Muted))
                .clipShape(Circle())
                .font(.system(size:14*sizeMultiplier, weight: .bold))
                .padding(.leading, 3*sizeMultiplier)
            
            Text(type?.name.localized() ?? "Type")
                .font(.system(size:15*sizeMultiplier, weight: .bold))
                .foregroundColor(Color(AssetColors.Primary))
                .padding(.vertical, 5*sizeMultiplier)
                .padding(.trailing, 8*sizeMultiplier)
        }
        .background(.thinMaterial)
        .cornerRadius(50)
    }
}

struct PokemonTypeBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            PokemonTypeBadge(type: PokemonType.allCases[3], sizeMultiplier: 1)
            Spacer()
            PokemonTypeBadge(type: PokemonType.allCases[2], sizeMultiplier: 2)
            Spacer()
            PokemonTypeBadge(type: PokemonType.allCases[1], sizeMultiplier: 3)
            Spacer()
        }
    }
}
