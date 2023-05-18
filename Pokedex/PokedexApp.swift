//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 08/03/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    init() {
        /** Styling components globally... */
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: AssetColors.Primary) ?? .black]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
