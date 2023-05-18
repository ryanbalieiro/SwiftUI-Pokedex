//
//  CompareTab.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import SwiftUI

struct CompareTab: View {
    @StateObject var compareTabViewModel = CompareTabViewModel()
    @StateObject var pokemonPickerViewModel = PokemonPickerViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            ComparationItem(species: compareTabViewModel.leftSpecies)
                                .onTapGesture {
                                    compareTabViewModel.setSelectingSlot(slot: .left)
                                }
                            
                            Spacer()
                            Image(systemName: "scale.3d")
                                .font(.title2)
                            
                            Spacer()
                            ComparationItem(species: compareTabViewModel.rightSpecies)
                                .onTapGesture {
                                    compareTabViewModel.setSelectingSlot(slot: .right)
                                }
                        }
                        .padding(.vertical, 25)
                        .padding(.horizontal, 30)
                        
                        Text("compare_tab_instructions".localized())
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(AssetColors.Muted))
                            .fontWeight(.medium)
                            .padding(.bottom, 10)
                            .frame(maxWidth: .infinity)
                        
                        ComparisonSheet(compareTabViewModel: compareTabViewModel)
                            .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                }
                .sheet(isPresented: $compareTabViewModel.showPokemonPicker) {
                    PokemonPicker(viewModel: pokemonPickerViewModel)
                }
                .navigationTitle("compare".localized())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
        pokemonPickerViewModel.delegate = compareTabViewModel
    }
}

struct CompareTab_Previews: PreviewProvider {
    static var previews: some View {
        CompareTab()
    }
}

fileprivate struct ComparationItem: View {
    let species:PokemonSpecies
    
    var body: some View {
        HStack {
            VStack {
                PokemonAvatar(species: species, imageFrameSize: 80)
                
                Text(species.name.capitalized)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color(AssetColors.Primary))
            }
        }
    }
}

fileprivate struct ComparisonSheet: View {
    @ObservedObject var compareTabViewModel:CompareTabViewModel
    
    var body: some View {
        VStack {
            ComparisonSheetItem(
                title: "weight".localized(),
                leftValue: compareTabViewModel.leftSpecies.weight,
                rightValue: compareTabViewModel.rightSpecies.weight,
                formatAsInteger: false,
                leftColor: leftColor,
                rightColor: rightColor
            )
            
            ComparisonSheetItem(
                title: "height".localized(),
                leftValue: compareTabViewModel.leftSpecies.height,
                rightValue: compareTabViewModel.rightSpecies.height,
                formatAsInteger: false,
                leftColor: leftColor,
                rightColor: rightColor
            )
            
            ComparisonSheetItem(
                title: "attack".localized(),
                leftValue: Double(compareTabViewModel.leftSpecies.attack),
                rightValue: Double(compareTabViewModel.rightSpecies.attack),
                formatAsInteger: true,
                leftColor: leftColor,
                rightColor: rightColor
            )
            
            ComparisonSheetItem(
                title: "defense".localized(),
                leftValue: Double(compareTabViewModel.leftSpecies.defense),
                rightValue: Double(compareTabViewModel.rightSpecies.defense),
                formatAsInteger: true,
                leftColor: leftColor,
                rightColor: rightColor
            )
        }
    }
    
    var leftColor: Color {
        return Color(compareTabViewModel.leftSpecies.types[0].name.capitalized)
    }
    
    var rightColor: Color {
        return Color(AssetColors.Muted)
    }
}

fileprivate struct ComparisonSheetItem: View {
    let title:String
    let leftValue:Double
    let rightValue:Double
    let formatAsInteger:Bool
    let leftColor:Color
    let rightColor:Color
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(AssetColors.Primary))
                .padding(.bottom, 5)
                .padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Text(formatDoubleValue(leftValue))
                    .frame(width: 50, alignment: .leading)
                
                ProgressBar(
                    percentage: leftValue/(leftValue+rightValue),
                    highlightColor: leftColor,
                    backgroundColor: rightColor
                )
                
                Text(formatDoubleValue(rightValue))
                    .frame(width: 50, alignment: .trailing)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
    
    func formatDoubleValue(_ value:Double) -> String {
        if formatAsInteger {
            return String(format: "%.0f", value)
        }
        return String(value)
    }
}
