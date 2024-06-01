//
//  FormatNumber.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 23/05/24.
//

import Foundation

extension NumberFormatter {
    convenience init(numberStyle: Style, locale: Locale = .current) {
        self.init()
        self.locale = locale
        self.numberStyle = numberStyle
    }
}
extension Character {
    var isDigit: Bool { "0"..."9" ~= self }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isDigit) }
    var decimal: Decimal? { Decimal(string: digits.string) }
}
class CurrencyManager: ObservableObject {
    @Published var string: String = ""
    
    private let formatter = NumberFormatter(numberStyle: .currency)
    private var maximum: Decimal = 999_999_999.99
    private var lastValue: String = ""
    
    init(amount: Decimal, maximum: Decimal = 999_999_999.99, locale: Locale = .current) {
        formatter.locale = locale
        self.string = formatter.string(for: amount) ?? "$0.00"
        self.lastValue = string
        self.maximum = maximum
    }
    
    func reset(with amount: Decimal = 0) {
        self.string = formatter.string(for: amount) ?? "$0.00"
        self.lastValue = string
    }
    
    func valueChanged(_ value: String) {
        let newValue = (value.decimal ?? .zero) / pow(10, formatter.maximumFractionDigits)
        if newValue > maximum {
            string = lastValue
        } else {
            string = formatter.string(for: newValue) ?? "$0.00"
            lastValue = string
        }
    }
    
    var doubleValue: Double? {
        guard let number = formatter.number(from: string) else {
            return nil
        }
        return number.doubleValue
    }
    
    public static var initial: CurrencyManager {
        .init(
            amount: 0,
            maximum: 999_999.99,
            locale: .init(identifier: "pt_BR")
        )
    }
}
