//
//  PokedexButton.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import SwiftUI

struct PokedexButton: View {
    let label: String
    let systemImage: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                Text(label)
            }
            .padding()
            .font(.headline)
            .foregroundColor(Color(AssetColors.Background))
            .background(Color(AssetColors.Primary))
        }
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(10)
    }
}

struct PokedexButton_Previews: PreviewProvider {
    static var previews: some View {
        PokedexButton(label: "Press Me", systemImage: "circle", action: {
            print("Button pressed!")
        })
    }
}
