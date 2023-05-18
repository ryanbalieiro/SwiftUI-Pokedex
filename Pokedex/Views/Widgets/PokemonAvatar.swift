//
//  PokemonAvatar.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import SwiftUI

struct PokemonAvatar: View {
    let species: PokemonSpecies?
    let imageFrameSize: CGFloat
    
    /** Fetch the pokemon avatar from the downloads folder, if it's been downloaded... */
    var uiImage:UIImage? {
        guard let species = species else {
            return nil
        }
        
        guard let data = BackendlessManager.shared.getDownloadedImageData(imageName: species.slug) else {
            return nil
        }
        
        return UIImage(data: data)
    }
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width:imageFrameSize, height:imageFrameSize)
        }
        else {
            ZStack {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                    .frame(width: imageFrameSize, height: imageFrameSize)
                    .foregroundColor(.black.opacity(0.6))
                    .background(.thinMaterial)
                    .clipShape(Circle())
            }
        }
    }
}

struct PokemonAvatar_Previews: PreviewProvider {
    static var previews: some View {
        PokemonAvatar(species: PokemonSpecies.samples[0], imageFrameSize: 160)
    }
}
