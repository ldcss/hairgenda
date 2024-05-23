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
  @State private var showImage: Bool = false
  @State private var initialDate: Date = Date()
  @State private var hydrateSelected:Bool = false
  @State private var nutritionSelected:Bool = false
  @State private var restorationSelected:Bool = false
  
  @State private var productValue: Decimal = 0.0
  
  @State private var daysNumber: Double = 20
  
  @State private var result: Decimal = 0
  
  var contentViewModel = ContentViewModel()
  
  var body: some View {
    VStack(spacing: 8){
      Spacer().frame(height: 50)
      HStack{
        Spacer()
        Text("Hairgenda").font(.display).frame(maxHeight: 50)
        Spacer()
      }.frame(width: .infinity)
      
      VStack(alignment: .leading, spacing: 32) {
        
        VStack(alignment: .leading, spacing: 12){
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
          }
          
          HStack{
            Text("Descubra sua curvatura aqui!").font(.system(size: 16, weight: .semibold, design: .rounded))
            
            Button {
              showImage.toggle()
            } label: {
              Image(systemName: "arrow.down.left.and.arrow.up.right")
                .tint(Color.black)
            }.popover(isPresented: $showImage, attachmentAnchor: .point(.trailing), arrowEdge: .bottom, content: {
              Image("ImgCurvatures")
                .resizable()
                .scaledToFit()
                .padding()
                .presentationCompactAdaptation(.popover)
                .frame(maxHeight: 250)
            })
            
          }
        }
        
        DatePicker("Início do cronograma", selection: $initialDate, displayedComponents: .date)
          .font(.system(size: 24, weight: .semibold, design: .rounded))
          .datePickerStyle(.compact)
          .tint(Color.green)
        
        VStack(alignment: .leading, spacing: 12) {
          Text("Etapas do cronograma").font(.system(size: 24, weight: .semibold, design: .rounded))
          
          Text("Selecione as etapas que estarão em seu cronograma!").font(.system(size: 16, weight: .semibold, design: .rounded))
          
          CustomCheckbox(CheckboxLabel: "Hidratação", isSelected: $hydrateSelected, popoverText: "A hidratação capilar repõe toda a água que seus fios perderam no decorrer dos dias.")
          
          CustomCheckbox(CheckboxLabel: "Nutrição", isSelected: $nutritionSelected, popoverText: "A nutrição age para devolver os nutrientes necessários para deixar os cabelos fortalecidos.")
          
          CustomCheckbox(CheckboxLabel: "Restauração", isSelected: $restorationSelected, popoverText: "A restauração capilar vai atuar para reconstituir a estrutura dos fios danificados.")
        }
        
        VStack(alignment: .leading, spacing: 12){
          Text("Valor total dos produtos")
            .font(.system(size: 24, weight: .semibold, design: .rounded))
          MoneyTextFieldView(amount: $productValue)
        }
        
        VStack(alignment: .leading, spacing: 12){
          Text("Tempo esperado de uso ")
            .font(.system(size: 24, weight: .semibold, design: .rounded))
          
          Stepper("Número de dias: \(Int(daysNumber))",
                  value: $daysNumber,
                  in: 0...90,
                  step: 1)
          .font(.system(size: 16, weight: .semibold, design: .rounded))
        }
        
        HStack{
          Spacer()
          Button("Realizar cálculo mensal") {
            result = productValue / Decimal(daysNumber)
            shouldPresentSheet.toggle()
            
          }
          .frame(width: 220)
          .font(.system(size: 18, weight: .bold, design: .rounded))
          .padding()
          .background(Color.purpleButton)
          .foregroundStyle(Color.white)
          .clipShape(RoundedRectangle(cornerRadius:14))
          Spacer()
        }
        Spacer()
      }
      .padding()
      .sheet(isPresented: $shouldPresentSheet) {
        print("Sheet dismissed!")
      } content: {
        SheetView(isPresented: $shouldPresentSheet, selectedCurvature: $selectedCurvature, result: result, hydrate: $hydrateSelected, nutrition: $nutritionSelected, restoration: $restorationSelected)
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


#Preview {
  ContentView()
}
