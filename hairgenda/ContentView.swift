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
  @State private var date: Date = Date.now
  @State
  @State private var dates: [SelectedDate] = [SelectedDate(date: Date.now, step: "Hidratação"), SelectedDate(date: Date.now, step: "Nutrição"), SelectedDate(date: Date.now, step: "Restauração")]
  
  var body: some View {
    VStack{
    Text("Hairgenda").font(.display)
    ScrollView {
      VStack{
        VStack(alignment: .leading, spacing: 20) {
          HStack {
            Text("Curvatura").font(.system(size: 24, weight: .semibold, design: .rounded))
            Spacer()
            Menu {
              Picker("Curvatura", selection: $selectedCurvature) {
                ForEach(Curvature.allCases) { curvature in
                  Text(curvature.rawValue)
                }
              }
            } label: {
              Text(selectedCurvature.rawValue)
                .padding()
                .frame(maxHeight: 30)
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .foregroundStyle(.black)
                .background(Color.backgroundGray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding()
            .frame(maxHeight: 30)
          }
          VStack(alignment: .leading, spacing: 12) {
            Text("Etapas do cronograma").font(.system(size: 24, weight: .semibold, design: .rounded))
            
            Text("Selecione a etapa e clique no dia do seu início").font(.system(size: 16, weight: .semibold, design: .rounded))
            Picker("Etapas", selection: $selectedStep) {
              ForEach(Step.allCases) { step in
                Text(step.rawValue).foregroundColor(Color.pink)
              }
            }.pickerStyle(.segmented)
              .colorMultiply(segmentedColor)
          }
          DatePicker(selectedStep.rawValue, selection: $date, displayedComponents: .date)
            .font(.system(size: 24, weight: .semibold, design: .rounded))
            .datePickerStyle(.compact)
            .tint(segmentedColor)
          
          CalendarView(canSelect: false, selectedDate: $date, selectedDates: dates)
          HStack{
            Spacer()
            Button("Realizar cálculo mensal") {
              print("date")
              print(date)
            }
            .frame(width: 220)
            .font(.system(size: 18, weight: .bold, design: .rounded))
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
  var segmentedColor: Color {
    switch selectedStep {
    case .hydrate:
      return Color.lightPink
    case .nutrition:
      return Color.lightGreen
    case .restoration:
      return Color.lightBlue
    }
  }
}

struct SelectedDate {
  var date: Date
  var step: String
}

#Preview {
  ContentView()
}
