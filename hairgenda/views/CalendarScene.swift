//
//  CalendarScene.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 20/05/24.
//

import SwiftUI

struct CalendarScene: View {
  @State private var selectedDate: Date = Date.now
  
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
        Spacer()
      }.padding()
    }
}

struct CalendarScene_Previews:PreviewProvider {
  static var previews: some View {
    CalendarScene()
  }
}
