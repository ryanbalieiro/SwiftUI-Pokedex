//
//  ContentViewModel.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 09/03/22.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var status:ViewStatus = .none
    @Published var pendingUserConfirmationToDisplayMenu = true
    
    private var cancellables: [AnyCancellable] = []
    private var backendlessCancelable: AnyCancellable?

    init() {
        loadData()
    }
    
    func loadData() {
        if(status != .none && status != .failedToDownload) {
            return
        }
        
        status = .downloadingResources
        
        backendlessCancelable = BackendlessManager.shared.completionSubject.sink(
            receiveCompletion: onFetchCompletion,
            receiveValue: {value in}
        )
        
        if let cancellable = backendlessCancelable {
            cancellable.store(in: &cancellables)
            BackendlessManager.shared.fetchData()
        }
    }
    
    func onFetchCompletion(completion: Subscribers.Completion<Error>) {
        DispatchQueue.main.async { [weak self] in
            switch completion {
            case .finished:
                self?.status = .readyToDisplay
                self?.backendlessCancelable?.cancel()
            case .failure:
                self?.status = .failedToDownload
            }
        }
    }
    
    enum ViewStatus {
        case none
        case downloadingResources
        case readyToDisplay
        case failedToDownload
    }
}
