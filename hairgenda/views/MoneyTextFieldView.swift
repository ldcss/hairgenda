//
//  MoneyTextFieldView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 23/05/24.
//

import SwiftUI

struct MoneyTextFieldView: View {
  @Binding var amount: Decimal
  @State var formattedAmount: String = ""
  
  private var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "BRL"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale(identifier: "pt_BR")
    return formatter
  }
  
  var body: some View {
    VStack {
      TextField("Amount", text: Binding(
        get: {
          formattedAmount
        },
        set: { newValue in
          formattedAmount = newValue
          if let number = currencyFormatter.number(from: newValue) {
            amount = number.decimalValue
          } else {
            amount = 0
          }
        }
      ))
      .keyboardType(.numberPad)
      .textFieldStyle(.roundedBorder)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .tint(.black)
      
    }
  }
}

//#Preview {
//    CustomTextfieldView()
//}
