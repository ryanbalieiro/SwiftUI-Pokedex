//
//  ContentView.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 09/03/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            if viewModel.status == .readyToDisplay && !viewModel.pendingUserConfirmationToDisplayMenu {
                ContentViewMenu().transition(.opacity)
            }
            else {
                PreloadView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

fileprivate struct ContentViewMenu: View {
    var body: some View {
        TabView {
            CatalogTab()
                .tabItem {
                    Image(systemName: "book")
                    Text("catalog".localized())
                }
            
            OwnedTab()
                .tabItem {
                    Image(systemName: "checkmark.seal.fill")
                    Text("owned".localized())
                }
            
            CompareTab()
                .tabItem {
                    Image(systemName: "scalemass.fill")
                    Text("compare".localized())
                }
            
            StatsTab()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("stats".localized())
                }
        }
        .accentColor(Color(AssetColors.Primary))
    }
}

