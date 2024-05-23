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
  
  @Binding var result: Double
  
  @Binding var hydrate: Bool
  @Binding var nutrition: Bool
  @Binding var restoration: Bool
  
  var resultByTime: String {
    switch timePeriod {
    case .monthly:
      return "Você irá gastar R$ \(result) em um mês!"
    case .semiannually:
      return "Você irá gastar R$ \(result * 6) em um semestre!"
    case .yearly:
      return "Você irá gastar R$ \(result * 12) em um ano!"
    }
  }
  
  var body: some View {
    HStack{
      RoundedRectangle(cornerRadius: 20)
        .foregroundStyle(.black)
        .background(.black)
        .padding()
    }.frame(width:40)
    
    VStack(spacing: 8){
      Text("Período de cálculo").font(.system(size: 24, weight: .semibold, design: .rounded))
      Picker("Etapas", selection: $timePeriod) {
        ForEach(TimePeriod.allCases) { timePeriod in
          Text(timePeriod.rawValue)
        }
      }.pickerStyle(.segmented)
      VStack(alignment: .center, spacing: 8){
        Text(resultByTime)
          .font(.system(size: 20, weight: .semibold, design: .rounded))
        
        HStack(spacing: 12){
          ChipView(systemImage: "drop", titleKey: "Hidratação", tint: Color.lightPink)
          
          ChipView(systemImage: "leaf", titleKey: "Nutrição", tint: Color.lightGreen)
          
          ChipView(systemImage: "arrow.clockwise", titleKey: "Restauração", tint: Color.lightBlue)
        }
        CalendarView(hydrate: $hydrate, nutrition: $nutrition, restoration: $restoration, selectedCurvature: $selectedCurvature)
          .frame(height:500)
        
      }
      
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
