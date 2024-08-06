//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 09/03/22.
//  This app is using Backendless (https://backendless.com/).
//  This class is responsible for fetching and interacting with the server-side of the application.
//

import Foundation
import SSZipArchive
import Combine

class BackendlessManager {
    static var shared = BackendlessManager()

    private var serverResponse:BackendlessResponse? = nil
    private var verbose:Bool = false
    
    public let completionSubject = PassthroughSubject<Bool, Error>()
    
    private var pathToAssetsFolder: String {
        guard let serverResponse = serverResponse else {
            return ""
        }
        
        return BackendlessManager.DESTINATION_URI + String(serverResponse.version) + "/"
    }
    
    var lastUpdate:String {
        guard let serverResponse = serverResponse else {
            return "-"
        }
        
        return serverResponse.lastUpdate
    }
    
    func getDownloadedImageData(imageName:String) -> Data? {
        let data = try? Data(contentsOf: URL(fileURLWithPath: pathToAssetsFolder + "images/" + imageName + ".png"))
        return data
    }
    
    func fetchData() {
        log(message: "Downloading Catalog...")
        
        guard let url = URL(string: BackendlessManager.CATALOG_URL) else {
            abortWithError(error: "Invalid catalog url.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.abortWithError(error: "Error downloading the catalog JSON.")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(BackendlessResponse.self, from: data)
                self.serverResponse = response
                self.log(message: "Managed to download the catalog!")
                PokemonSpecies.allCases = response.pokemon
                
                self.checkAssets()
            }
            catch {
                self.abortWithError(error: "Error parsing the catalog data!")
            }
        }
        
        task.resume()
    }
    
    private func checkAssets() {
        log(message: "Checking assets...")
        
        let fileManager = FileManager.default
        /** Assets are up-to-date! */
        if(fileManager.fileExists(atPath: pathToAssetsFolder)) {
            finish()
            return
        }
        
        deleteOldAssets()
    }
    
    private func deleteOldAssets() {
        log(message: "Deleting old assets...")
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: BackendlessManager.DESTINATION_URI) {
            do {
                try fileManager.removeItem(atPath: BackendlessManager.DESTINATION_URI)
            }
            catch {
                abortWithError(error: "Failed to delete old assets.")
                return
            }
        }
        
        updateAssets()
    }
    
    private func updateAssets() {
        log(message: "Updating assets...")
        
        guard let url = URL(string: BackendlessManager.ASSETS_URL) else {
            abortWithError(error: "Invalid assets url.")
            return
        }
        
        let task = URLSession.shared.downloadTask(with: url) { localURL, response, error in
            if let localURL = localURL {
                self.unzipAssets(localUrl: localURL)
            }
            else {
                self.abortWithError(error: "Failed to download assets.")
            }
        }
        
        task.resume()
    }
    
    private func unzipAssets(localUrl:URL) {
        do {
            try SSZipArchive.unzipFile(
                atPath: localUrl.path,
                toDestination: pathToAssetsFolder,
                overwrite: true,
                password: nil
            )
            
            finish()
        }
        catch {
            self.abortWithError(error: "Failed to unzip the assets.")
        }
    }
    
    private func abortWithError(error:String) {
        log(message: "Error: " + error)
        let nsError = NSError(domain: "BackendlessErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: error])
        completionSubject.send(completion: .failure(nsError))
    }
    
    private func finish() {
        log(message: "Update completed!")
        completionSubject.send(true)
        completionSubject.send(completion: .finished)
    }
    
    private func log(message:String) {
        if(verbose) {
            print(message)
        }
    }
}

/** URLs */
extension BackendlessManager {
    private static let CATALOG_URL = "https://ryanbalieiro.com/assets/static/pokemon.json"
    private static let ASSETS_URL = "https://ryanbalieiro.com/assets/static/pokemon.zip"
    private static let DESTINATION_URI = NSTemporaryDirectory() + "assets/"
}

/** Server Response structure */
fileprivate struct BackendlessResponse: Decodable {
    let version: Int
    let lastUpdate:String
    let pokemon: [PokemonSpecies]
}
