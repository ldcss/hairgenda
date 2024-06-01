//
//  SheetView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 21/05/24.
//

import SwiftUI

struct SheetView: View {
  @Binding var isPresented: Bool
  @Binding var selectedCurvature: Curvature
  @Binding var hydrate: Bool
  @Binding var nutrition: Bool
  @Binding var restoration: Bool
  @Binding var initialDate: Date
  @Binding var finishedDate: Date
  
  var body: some View {
    VStack(spacing: 8){
      Spacer()
      Capsule()
        .frame(width: 120, height: 10)  // Adjust the width and height as needed
        .foregroundColor(.black)         // Set the color of the line
        .padding()
      Spacer()
      HStack(spacing: 12){
        ChipView(systemImage: "drop.fill", titleKey: "Hidratação", tint: Color.lightPink)
        
        ChipView(systemImage: "leaf.fill", titleKey: "Nutrição", tint: Color.lightGreen)
        
        ChipView(systemImage: "arrow.clockwise", titleKey: "Restauração", tint: Color.lightBlue)
      }
      CalendarView(hydrate: $hydrate, nutrition: $nutrition, restoration: $restoration, selectedCurvature: $selectedCurvature, initialDate: $initialDate, finishedDate: $finishedDate)
        .frame(height:500)
    }
    ButtonView(text: "Voltar"){
      isPresented.toggle()
    }
    Spacer()
  }
}


//#Preview {
//  SheetView()
//}
