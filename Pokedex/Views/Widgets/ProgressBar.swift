//
//  ProgressBar.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 12/03/22.
//

import SwiftUI

struct ProgressBar:View {
    var percentage:Double
    var highlightColor:Color
    var backgroundColor:Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(1)
                    .foregroundColor(backgroundColor)
                
                Rectangle()
                    .frame(width: min(CGFloat(percentage)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(highlightColor)
            }
        }
        .frame(height: 20)
        .cornerRadius(10)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(
            percentage: 0.1,
            highlightColor: Color(AssetColors.Primary),
            backgroundColor: Color.gray.opacity(0.3)
        )
        .padding()
    }
}
