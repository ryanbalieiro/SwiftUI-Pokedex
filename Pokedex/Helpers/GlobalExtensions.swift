//
//  Extensions.swift
//  Pokedex
//
//  Created by Ryan Balieiro on 10/03/22.
//

import Foundation

extension Date {
    func toMMDDYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment:self)
    }
}
