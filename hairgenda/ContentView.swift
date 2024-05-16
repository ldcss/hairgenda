//
//  ContentView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 15/05/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var selectedCurvature: Curvature = .none
  @State private var selectedStep: Step = .hydrate
  @State private var showPicker: Bool = false
  
  @State private var wakeUp = Date.now
  
  var body: some View {
    ZStack{
      if (showPicker == true) {
        VStack{
          Picker("Curvatura", selection: $selectedCurvature) {
            ForEach(Curvature.allCases) { curvature in
              Text(curvature.rawValue)
            }
          }.pickerStyle(.wheel)
        }
        .onChange(of: selectedCurvature) {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            showPicker = false
          }
        }
        .animation(.easeOut(duration: 5), value: showPicker)
        .frame(height: 200)
        .frame(width: 200)
        .background(Color.backgroundGray)
        .clipShape(RoundedRectangle(cornerRadius: 16))
      }
      ZStack{
        VStack{
          Text("Hairgenda").font(.display)
          VStack(alignment: .leading, spacing: 20) {
            HStack {
              Text("Curvatura").font(.system(size: 24, weight: .semibold, design: .rounded))
              Spacer()
              Button(selectedCurvature.rawValue) {
                showPicker = true
              }
              .padding()
              .frame(maxHeight: 30 )
              .background(Color.backgroundGray)
              .foregroundStyle(.black)
              .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            VStack(alignment: .leading, spacing: 12) {
              Text("Etapas do cronograma").font(.system(size: 24, weight: .semibold, design: .rounded))
              
              Text("Selecione a etapa e clique no dia do seu início").font(.system(size: 16, weight: .semibold, design: .rounded))
              Picker("Etapas", selection: $selectedStep) {
                ForEach(Step.allCases) { step in
                  Text(step.rawValue).foregroundColor(Color.pink)
                }
              }.pickerStyle(.segmented)
                .foregroundColor(Color.pink)
            }
            HStack {
              Text(selectedStep.rawValue).font(.system(size: 24, weight: .semibold, design: .rounded))
              Spacer()
              Button("Selecionar") {
                showPicker = true
              }
              .padding()
              .frame(maxHeight: 30 )
              .background(Color.backgroundGray)
              .foregroundStyle(.black)
              .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .date)
              .labelsHidden()
              .datePickerStyle(.graphical)
            HStack{
              Spacer()
              Button("Realizar cálculo mensal") {
                
              }
              .frame(width: 180)
              .font(.system(size: 14, weight: .bold, design: .rounded))
              .padding()
              .background(Color.purpleButton)
              .foregroundStyle(Color.white)
              .clipShape(RoundedRectangle(cornerRadius:14))
              .onTapGesture {
                withAnimation(.easeInOut) {
                  print("teste")
                }
              }
              Spacer()
            }
            Spacer()
          }
          .padding()
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
