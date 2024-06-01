//
//  CalendarScene.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 20/05/24.
//

import SwiftUI

struct CalendarScene: View {
  @State private var selectedDate: Date = Date.now
  
  @State private var isSelected: Bool = false
  
  private var textDate: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: selectedDate)
  }
  
    var body: some View {
      VStack{
        Text("Calendars Go Here!")
        Spacer()
//        CalendarView(selectedDate: $selectedDate)
//          .scaledToFit()
        Group {
          Toggle("Teste", isOn: $isSelected)
            .labelsHidden()
            .toggleStyle(.checklist)
            .font(.title)
            .tint(.black)
        }
        Spacer()
      }.padding()
    }
}

struct CalendarScene_Previews:PreviewProvider {
  static var previews: some View {
    CalendarScene()
  }
}
