//
//  MoneyViewModel.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 23/05/24.
//

import Foundation
import SwiftUI
import Combine

class MoneyViewModel: ObservableObject {
    @Published var rawValue: Double = 0.0 {
        didSet {
            formattedValue = formatter.string(from: NSNumber(value: rawValue)) ?? ""
        }
    }
    @Published var formattedValue: String = ""

    let formatter: NumberFormatter
    
    init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formattedValue = formatter.string(from: NSNumber(value: rawValue)) ?? ""
    }
    
    func updateRawValue(from string: String) {
        if let number = formatter.number(from: string) {
            rawValue = number.doubleValue
        } else {
            formattedValue = string
        }
    }
}
