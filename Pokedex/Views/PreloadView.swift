//
//  PreloadView.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import SwiftUI

struct PreloadView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        ZStack {
            GradientBackground()
            
            VStack {
                VStack(alignment: .leading) {
                    Text("preload_welcome_message".localized())
                        .foregroundColor(Color(AssetColors.Muted))
                    
                    Text("preload_title".localized())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(AssetColors.Primary))
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(30)
                
                Spacer()
                Image("Pokeball")
                    .scaledToFit()
                
                /** Load Status Dynamic Display */
                Spacer()
                VStack {
                    switch(viewModel.status) {
                    case .downloadingResources: PreloadViewProgress()
                    case .failedToDownload: PreloadViewFailed(viewModel: viewModel)
                    case .readyToDisplay: PreloadViewSuccess(viewModel: viewModel)
                    default: EmptyView()
                    }
                }
                .frame(height: 200)
            }
        }
    }
}

struct PreloadView_Previews: PreviewProvider {
    static var previews: some View {
        PreloadView(viewModel: ContentViewModel())
    }
}

/** SubView to display the downloading progres... */
fileprivate struct PreloadViewProgress: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.blue)
                .padding(.bottom, 10)
            
            Text("loading".localized() + "...")
                .foregroundColor(Color(AssetColors.Muted))
        }
    }
}

/** SubView to display the proceed button... */
fileprivate struct PreloadViewSuccess: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        PokedexButton(label: "proceed".localized(), systemImage: "arrow.right.to.line") {
            withAnimation {
                viewModel.pendingUserConfirmationToDisplayMenu.toggle()
            }
        }
        
        Text("preload_made_by".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(Color(AssetColors.Muted))
            .fontWeight(.medium)
            .padding(25)
    }
}

/** SubView to display the downloading progres... */
fileprivate struct PreloadViewFailed: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        PokedexButton(label: "retry".localized(), systemImage: "arrow.uturn.forward.circle.fill") {
            viewModel.loadData()
        }
        
        Text("preload_retry_error".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(Color(AssetColors.Danger))
            .fontWeight(.medium)
            .padding(25)
    }
}
