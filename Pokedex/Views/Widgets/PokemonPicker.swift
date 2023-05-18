//
//  PokemonPicker.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import SwiftUI

struct PokemonPicker: View {
    @ObservedObject var viewModel:PokemonPickerViewModel
    
    var body: some View {
        Form {
            /** Form Title*/
            Text("pokemon_picker_select".localized())
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetColors.Primary))
                .padding(.vertical)
            
            /** Input Field*/
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("pokemon_picker_enter_name".localized(), text: $viewModel.searchTerm)
                    .disableAutocorrection(true)
            }
            .padding(.vertical, 10)
            
            VStack {
                /** Display preview and add button */
                if let species = viewModel.selectedSpecies {
                    PokemonPickerSelector(viewModel: viewModel, pokemonSpecies:species)
                }
                /** Species not found*/
                else {
                    PokemonPickerNotFound()
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            viewModel.reset()
        }
    }
    
    /** Layout constants */
    static let PREVIEW_FONT_SIZE = CGFloat(17)
    static let PREVIEW_IMAGE_SIZE = CGFloat(80)
    static let PREVIEW_IMAGE_PADDING = CGFloat(5)
}

struct PokemonPicker_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPicker(viewModel: PokemonPickerViewModel())
    }
}

/** Subview to display a preview along with the confirmation button */
fileprivate struct PokemonPickerSelector: View {
    @ObservedObject var viewModel:PokemonPickerViewModel
    let pokemonSpecies:PokemonSpecies
    
    var body: some View {
        VStack {
            PokemonAvatar(species: pokemonSpecies, imageFrameSize: PokemonPicker.PREVIEW_IMAGE_SIZE)
                .padding(.bottom, PokemonPicker.PREVIEW_IMAGE_PADDING)
            
            Text("\(pokemonSpecies.name.capitalized)")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetColors.Primary))
            
            PokedexButton(label: "add".localized(), systemImage: "plus") {
                viewModel.confirmSelection()
            }
            .padding(.vertical, 10)
        }
    }
}

/** Subview to display a 'not found' message */
fileprivate struct PokemonPickerNotFound: View {
    var body: some View {
        VStack {
            Image(AssetImages.PokeballIconDisabled).opacity(0.6)
                .scaledToFit()
                .frame(width: PokemonPicker.PREVIEW_IMAGE_SIZE, height: PokemonPicker.PREVIEW_IMAGE_SIZE)
                .padding(.bottom, PokemonPicker.PREVIEW_IMAGE_PADDING)
            
            Text("not_found".localized() + "!")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetColors.Muted))
                .opacity(0.6)
        }
    }
}
