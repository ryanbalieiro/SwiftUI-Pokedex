//
//  Utils.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 12/05/23.
//

import Foundation
import SwiftUI

class Utils {
    
    /** Helper function to create a simple error message to the user. */
    static func makeErrorAlert(message: String) -> Alert {
        return Alert(
            title: Text("Error!"),
            message: Text(message),
            dismissButton: .default(Text("OK"))
        )
    }
    
    static func formattedDate(date:Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: date)
        }
        else {
            return "-"
        }
    }
}
