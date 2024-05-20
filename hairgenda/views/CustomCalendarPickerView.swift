//
//  CustomCalendarPickerView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 16/05/24.
//

import SwiftUI

struct CustomCalendarPickerView: View {
  @State private var wakeUp = Date.now
  @State private var dates: Set<DateComponents> = []
  
    var body: some View {
      VStack{
        Spacer()
        MultiDatePicker("Select a date", selection: $dates)
          .frame(maxHeight: 200)
          .tint(.orange)
          .padding()
        Spacer()
        Button("Teste"){
          print(dates)
        }
      }.padding()
      
      
//      DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .date)
////          .colorInvert()
////          .colorMultiply(.red)
//        .labelsHidden()
//        .datePickerStyle(.graphical)
        
    }
}

#Preview {
    CustomCalendarPickerView()
}
