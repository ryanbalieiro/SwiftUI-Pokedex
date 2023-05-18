//
//  PokemonSpeciesView.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 12/03/22.
//

import SwiftUI

struct SpeciesView: View {
    let species:PokemonSpecies
    
    var body: some View {
        ZStack {
            /** Background */
            Color(species.types[0].name.capitalized)
            
            ScrollView {
                ZStack {
                    /** Background Overlay */
                    Color(AssetColors.Background)
                        .cornerRadius(50)
                        .padding(.top, 150)
                    
                    /** Content */
                    SpeciesViewContent(species: species)
                        .padding(.top, 70)
                        .padding(.bottom, 100)
                }
                .frame(minHeight: UIScreen.main.bounds.height)
            }
        }
        .ignoresSafeArea()
    }
}

struct SpeciesView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesView(species: PokemonSpecies.allCases[0])
    }
}

/** Vertical Container that will be the 'body' of the main scroll view. */
fileprivate struct SpeciesViewContent: View {
    let species:PokemonSpecies
    var body: some View {
        VStack {
            PokemonAvatar(species: species, imageFrameSize: 160)
            
            HStack {
                Text(species.name.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(AssetColors.Primary))
                
                PokemonStatusBadge(owned: CoreDataManager.shared.hasPokemon(species: species))
                    .frame(maxWidth: 25)
            }
            
            HStack {
                ForEach(species.types) { type in
                    PokemonTypeBadge(type: type, sizeMultiplier: 1.3)
                }
            }
            
            VStack {
                SpeciesViewContentSubtitle(text: "description".localized())
                
                Text(species.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SpeciesViewContentSubtitle(text: "stats".localized())
                    .padding(.top, 25)
                
                SpeciesViewStat(title: "weight".localized(), value: species.weight, suffix: "kg")
                SpeciesViewStat(title: "height".localized(), value: species.weight, suffix: "m")
                SpeciesViewProgressStat(title: "attack".localized(), value: species.attack, maxValue: 180)
                SpeciesViewProgressStat(title: "defense".localized(), value: species.defense, maxValue: 180)
                
                SpeciesViewContentSubtitle(text: "evolution_chain".localized())
                    .padding(.top, 25)
                
                PokemonEvolutionChain(species: species)
                    .padding(.top, 5)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(20)
            
            Spacer()
        }
    }
}

/** Subview to format the subtitles of the content. */
fileprivate struct SpeciesViewContentSubtitle: View {
    let text:String
    
    var body: some View {
        return Text(text)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color(AssetColors.Primary))
            .padding(.bottom, 5)
            .padding(.top, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/** Subview to display a raw numeric stat. */
fileprivate struct SpeciesViewStat: View {
    let title:String
    let value:Double
    let suffix:String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .frame(width: 100, alignment: .leading)
            
            let formattedValue = String(format: "%.2f", value)
            Text("\(formattedValue) \(suffix)")
                .fontWeight(.bold)
                .frame(width: 120, alignment: .leading)
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

/** Subview to display a stat with a progressbar.*/
fileprivate struct SpeciesViewProgressStat: View {
    let title:String
    let value:Int
    let maxValue:Double
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .frame(width: 100, alignment: .leading)
            
            ProgressBar(
                percentage: Double(value)/Double(maxValue),
                highlightColor:Color(AssetColors.Primary),
                backgroundColor: Color.gray.opacity(0.3)
            )
            
            Text("\(value)")
                .fontWeight(.bold)
                .frame(width: 60, alignment: .trailing)
        }
        .padding(.bottom, 10)
    }
}
