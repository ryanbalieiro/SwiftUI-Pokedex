//
//  OwnedTab.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 11/03/22.
//

import SwiftUI

struct OwnedTab: View {
    @StateObject var ownedTabViewModel = OwnedTabViewModel()
    @StateObject var pokemonPickerViewModel = PokemonPickerViewModel()
    @StateObject var coreDataManager = CoreDataManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                VStack(alignment: .leading) {
                    OwnedList(ownedTabViewModel: ownedTabViewModel)
                }
                .navigationTitle("owned".localized())
                .toolbar {
                    Button(action: onToolbarPlusButtonTapped) {
                        Label("add".localized(), systemImage: "plus.circle")
                    }
                }
                .sheet(isPresented: $ownedTabViewModel.showRegisterMenu) {
                    PokemonPicker(viewModel: pokemonPickerViewModel)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: onAppear)
        .alert(isPresented: $ownedTabViewModel.showErrorMessage) {
            Alert(
                title: Text("error".localized()),
                message: Text(ownedTabViewModel.errorMessage),
                dismissButton: .default(Text("ok".localized()))
            )
        }
    }
    
    private func onAppear() {
        pokemonPickerViewModel.delegate = ownedTabViewModel
    }
    
    private func onToolbarPlusButtonTapped() {
        ownedTabViewModel.showRegisterMenu.toggle()
    }
}

struct OwnedTab_Previews: PreviewProvider {
    static var previews: some View {
        OwnedTab()
    }
}

fileprivate struct OwnedList: View {
    @ObservedObject var ownedTabViewModel:OwnedTabViewModel
    @StateObject var coreDataManager = CoreDataManager.shared
    
    var body: some View {
        if listItems.isEmpty {
            VStack {
                Image(AssetImages.PokeballIconDisabled)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .opacity(0.6)
                
                Text("no_owned".localized())
                    .font(.title2)
                    .foregroundColor(Color(AssetColors.Muted))
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        else {
            List {
                ForEach(listItems) { pokemonEntity in
                    OwnedListItem(pokemonEntity: pokemonEntity)
                }
                .onDelete(perform: onDelete)
                .listRowBackground(Color(AssetColors.Background).opacity(0.2))
            }
            .searchable(text: $ownedTabViewModel.listSearchTerm)
            .disableAutocorrection(true)
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
    }
    
    var listItems: [PokemonEntity] {
        return ownedTabViewModel.getFilterResults(coreDataManager.pokemonList)
    }
    
    func onDelete(indexSet:IndexSet) {
        withAnimation {
            let indices = Array(indexSet)
            let pokemonToDelete = indices.map { listItems[$0] }
            pokemonToDelete.forEach {
                ownedTabViewModel.deletePokemon(pokemonEntity: $0)
            }
        }
    }
}

fileprivate struct OwnedListItem: View {
    let pokemonEntity:PokemonEntity
    
    var body: some View {
        HStack {
            if let species = PokemonSpecies.fromId(pokemonEntity.speciesId) {
                PokemonAvatar(species: species, imageFrameSize: 50)
                    .padding(.trailing, 10)
                
                Text(species.name.capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(AssetColors.Primary))
                    .dynamicTypeSize(.large ... .xxxLarge)
                    .padding(.vertical, 5)
                
                Spacer()
                
                Text(pokemonEntity.dateAdded?.toMMDDYY() ?? "-")
                    .font(.callout)
                    .foregroundColor(Color(AssetColors.Muted))
                    .dynamicTypeSize(.large ... .xxxLarge)
            }
            else {
                Image(AssetImages.PokeballIconDisabled).opacity(0.6)
                    .scaledToFit()
                
                Text("unknown".localized())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(AssetColors.Muted))
                    .padding(.vertical, 5)
            }
        }
    }
}
