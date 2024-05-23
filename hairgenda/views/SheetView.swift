//
//  SheetView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 21/05/24.
//

import SwiftUI

struct SheetView: View {
  
  @Binding var isPresented: Bool
  
  @State private var timePeriod: TimePeriod = .monthly
  
  @Binding var selectedCurvature: Curvature
  
  @Binding var hydrate: Bool
  @Binding var nutrition: Bool
  @Binding var restoration: Bool
  
  var body: some View {
    VStack{
      Text("Período de cálculo").font(.system(size: 24, weight: .semibold, design: .rounded))
      Picker("Etapas", selection: $timePeriod) {
        ForEach(TimePeriod.allCases) { timePeriod in
          Text(timePeriod.rawValue)
        }
      }.pickerStyle(.segmented)
      VStack(alignment: .center){
        Text("Você irá gastar R$250 esse mês!")
          .font(.system(size: 44, weight: .semibold, design: .rounded))
        
        HStack(spacing: 12){
          ChipView(systemImage: "drop", titleKey: "Hidratação", tint: Color.lightPink)
          
          ChipView(systemImage: "leaf", titleKey: "Nutrição", tint: Color.lightGreen)
          
          ChipView(systemImage: "arrow.clockwise", titleKey: "Restauração", tint: Color.lightBlue)
        }
        CalendarView(hydrate: $hydrate, nutrition: $nutrition, restoration: $restoration, selectedCurvature: $selectedCurvature)
          .frame(height:500)
        
      }
      
      Spacer()
      
      Button("Voltar") {
        isPresented.toggle()
      }
      .frame(width: 220)
      .font(.system(size: 18, weight: .bold, design: .rounded))
      .padding()
      .background(Color.purpleButton)
      .foregroundStyle(Color.white)
      .clipShape(RoundedRectangle(cornerRadius:14))
      
    }.padding()
  }
}

//#Preview {
//  SheetView()
//}
