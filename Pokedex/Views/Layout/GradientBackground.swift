//
//  BackgroundView.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 09/03/22.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors:[Color(AssetColors.Background), Color(AssetColors.BackgroundContrast)]),
            startPoint:.top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
