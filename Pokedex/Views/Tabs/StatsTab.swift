//
//  StatsTab.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 15/03/22.
//

import SwiftUI

struct StatsTab: View {
    @StateObject var viewModel = StatsTabViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackground()
                
                Form {
                    Section(header: Text("owned_pokemon".localized())) {
                        StatsItem(label: "total".localized(), value: viewModel.totalOwnedStr)
                        StatsItem(label: "without_duplications".localized(), value: viewModel.totalOwnedWithoutDuplicationsStr)
                    }
                    .listRowBackground(StatsTab.LIST_ROW_BACKGROUND)
                    
                    Section(header: Text("progress".localized())) {
                        StatsItem(label: "total_species".localized(), value: viewModel.totalSpeciesStr)
                        StatsItem(label: "total_found".localized(), value: viewModel.totalOwnedWithoutDuplicationsStr)
                        StatsItem(label: "percentage".localized(), value: viewModel.percentageStr)
                    }
                    .listRowBackground(StatsTab.LIST_ROW_BACKGROUND)
                    
                    Section(header: Text("about".localized())) {
                        StatsItem(label: "version".localized(), value: viewModel.versionStr)
                        StatsItem(label: "last_update".localized(), value: viewModel.lastUpdateStr)
                    }
                    .listRowBackground(StatsTab.LIST_ROW_BACKGROUND)
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("stats".localized())
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.updateStats()
        }
    }
    
    static let LIST_ROW_BACKGROUND = Color(AssetColors.Background)
}

fileprivate struct StatsItem: View {
    let label:String
    let value:String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
        }
    }
}

struct StatsTab_Previews: PreviewProvider {
    static var previews: some View {
        StatsTab()
    }
}
