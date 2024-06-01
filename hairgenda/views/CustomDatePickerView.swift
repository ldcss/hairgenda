//
//  CustomDatePickerView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 27/05/24.
//

import SwiftUI

struct CustomDatePickerView: View {
  @State var text: String
  
  @Binding var date: Date
  
  var body: some View {
    DatePicker(text, selection: $date, displayedComponents: .date)
      .lineLimit(nil)
      .multilineTextAlignment(.leading)
      .font(.system(size: 24, weight: .semibold, design: .rounded))
      .datePickerStyle(.compact)
      .tint(Color.purpleButton)
      .id(date)
  }
}

//
//#Preview {
//    CustomDatePickerView()
//}
