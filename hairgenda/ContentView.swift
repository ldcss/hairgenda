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
  @State var shouldPresentSheet = false
  @State private var hydrateDate: Date = Date.now
  @State private var nutritionDate: Date = Date.now
  @State private var restorationDate: Date = Date.now
  
  @State private var hydrateSelected:Bool = false
  @State private var nutritionSelected:Bool = false
  @State private var restorationSelected:Bool = false
  
  
  var body: some View {
    VStack{
      Text("Hairgenda").font(.display).frame(maxHeight: 50)
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
              
              Text("Selecione as etapas que estarão em seu cronograma!").font(.system(size: 16, weight: .semibold, design: .rounded))
              //              Picker("Etapas", selection: $selectedStep) {
              //                ForEach(Step.allCases) { step in
              //                  Text(step.rawValue).foregroundColor(Color.pink)
              //                }
              //              }.pickerStyle(.segmented)
              //                .colorMultiply(segmentedColor)
              CustomCheckbox(CheckboxLabel: "Hidratação", isSelected: $hydrateSelected, popoverText: "A hidratação capilar repõe toda a água que seus fios perderam no decorrer dos dias.")
              
              CustomCheckbox(CheckboxLabel: "Nutrição", isSelected: $nutritionSelected, popoverText: "A nutrição age para devolver os nutrientes necessários para deixar os cabelos fortalecidos.")
              
              CustomCheckbox(CheckboxLabel: "Restauração", isSelected: $restorationSelected, popoverText: "A restauração capilar vai atuar para reconstituir a estrutura dos fios danificados.")
            }
            
              CalendarView(canSelect: false, hydrateDate: $hydrateDate,  nutritionDate: $nutritionDate,
                           restorationDate: $restorationDate)
              .frame(height:400)
            
            HStack{
              Spacer()
              Button("Realizar cálculo mensal") {
                shouldPresentSheet.toggle()
              }
              .frame(width: 220)
              .font(.system(size: 18, weight: .bold, design: .rounded))
              .padding()
              .background(Color.purpleButton)
              .foregroundStyle(Color.white)
              .clipShape(RoundedRectangle(cornerRadius:14))
              .onTapGesture {
                withAnimation(.easeInOut) {
                }
              }
              Spacer()
            }
            Spacer()
          }
          .padding()
        }
        .sheet(isPresented: $shouldPresentSheet) {
          print("Sheet dismissed!")
        } content: {
          SheetView()
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
  
  var stepPicker: some View {
    switch selectedStep {
    case .hydrate:
      return DatePicker(selectedStep.rawValue, selection: $hydrateDate, displayedComponents: .date)
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .datePickerStyle(.compact)
        .tint(segmentedColor)
    case .nutrition:
      return DatePicker(selectedStep.rawValue, selection: $nutritionDate, displayedComponents: .date)
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .datePickerStyle(.compact)
        .tint(segmentedColor)
    case .restoration:
      return DatePicker(selectedStep.rawValue, selection: $restorationDate, displayedComponents: .date)
        .font(.system(size: 24, weight: .semibold, design: .rounded))
        .datePickerStyle(.compact)
        .tint(segmentedColor)
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
