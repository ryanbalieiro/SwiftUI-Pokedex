//
//  CatalogTab.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import SwiftUI

struct CatalogTab: View {
    @StateObject var catalogTabViewModel = CatalogTabViewModel()
    @StateObject var coreDataManager = CoreDataManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 5) {
                        ForEach(catalogTabViewModel.filteredResults) { species in
                            CatalogCell(
                                species: species,
                                owned: coreDataManager.hasPokemon(species: species)
                            )
                        }
                    }
                    .padding()
                    .searchable(text: $catalogTabViewModel.searchInput)
                    .disableAutocorrection(true)
                }
                .navigationTitle("catalog".localized())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var gridColumns: [GridItem] {
        return [GridItem(.adaptive(minimum: 160))]
    }
}

struct CatalogTab_Previews: PreviewProvider {
    static var previews: some View {
        CatalogTab()
    }
}

fileprivate struct CatalogCell: View {
    let species: PokemonSpecies
    let owned: Bool
    
    var body: some View {
        ZStack {
            /** Wraps the background rectangle with the link to the SpeciesView */
            NavigationLink(destination: SpeciesView(species:species)) {
                Rectangle()
                    .foregroundColor(Color(species.types[0].name.capitalized))
                    .cornerRadius(12)
                    .opacity(owned ? 1 : 0.3)
            }
            
            VStack {
                /** Pokemon Avatar */
                PokemonAvatar(species: species, imageFrameSize:80)
                    .offset(y: -30)
                    .allowsHitTesting(false)
                
                VStack(alignment: .leading) {
                    /** Pokemon ID*/
                    Text("#\(String(format:"%03d", species.id))")
                        .font(.subheadline)
                        .dynamicTypeSize(.large ... .xxxLarge)
                    
                    /** Pokemon Name */
                    Text(species.name.capitalized)
                        .font(.title3)
                       .fontWeight(.bold)
                       .foregroundColor(Color(AssetColors.Primary))
                       .dynamicTypeSize(.large ... .xxxLarge)
                    
                    /** Type Badge and Status Badge*/
                    HStack {
                        PokemonTypeBadge(type: species.types.first)
                        
                        Spacer()
                        
                        PokemonStatusBadge(owned: owned)
                            .frame(width: 30, height: 30)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .offset(y: -25)
            }
        }
        .padding(.vertical, 20)
    }
}
