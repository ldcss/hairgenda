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
  
  @ObservedObject private var currencyManagerBR = CurrencyManager.initial
  
  @State private var daysNumber: Double = 20
  
  @State private var result: Double = 0
  
  @State var withoutCurvature = false
  @State var withoutSteps = false
  @State var withoutTotalValue = false
  
  var body: some View {
    NavigationStack {
      HStack{
        Spacer()
        Text("HairGenda").font(.display).frame(maxHeight: 50)
        Spacer()
      }
      ScrollView{
        VStack(spacing: 8){
          
          VStack(alignment: .leading, spacing: 32) {
            
            VStack(alignment: .leading, spacing: 12){
              HStack {
                Text("Curvatura").font(.system(size: 23, weight: .semibold, design: .rounded))
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
              .lineLimit(nil)
              .multilineTextAlignment(.leading)
              .font(.system(size: 23, weight: .semibold, design: .rounded))
              .datePickerStyle(.compact)
              .tint(Color.purpleButton)
            
            VStack(alignment: .leading, spacing: 12) {
              Text("Etapas do cronograma").font(.system(size: 23, weight: .semibold, design: .rounded))
              
              Text("Selecione as etapas que estarão em seu \n cronograma!")
                .frame(height: 40)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
              
              CustomCheckbox(CheckboxLabel: "Hidratação", isSelected: $hydrateSelected, popoverText: "A hidratação capilar repõe toda a água que seus fios perderam no decorrer dos dias.")
              
              CustomCheckbox(CheckboxLabel: "Nutrição", isSelected: $nutritionSelected, popoverText: "A nutrição age para devolver os nutrientes necessários para deixar os cabelos fortalecidos.")
              
              CustomCheckbox(CheckboxLabel: "Restauração", isSelected: $restorationSelected, popoverText: "A restauração capilar vai atuar para reconstituir a estrutura dos fios danificados.")
            }
            
            VStack(alignment: .leading, spacing: 12){
              Text("Valor total dos produtos")
                .font(.system(size: 23, weight: .semibold, design: .rounded))
              
              TextField(currencyManagerBR.string, text: $currencyManagerBR.string)
                .keyboardType(.numberPad)
                .onChange(of: currencyManagerBR.string, perform: currencyManagerBR.valueChanged)
                .textFieldStyle(.roundedBorder)
                .tint(.black)
            }
            
            VStack(alignment: .leading, spacing: 12){
              Text("Tempo esperado de uso ")
                .font(.system(size: 23, weight: .semibold, design: .rounded))
              
              Stepper("Número de dias: \(Int(daysNumber))",
                      value: $daysNumber,
                      in: 0...90,
                      step: 1)
              .font(.system(size: 16, weight: .semibold, design: .rounded))
              .background(.white)
            }
            
            HStack{
              Spacer()
              Button("Realizar cálculo mensal") {
                if (selectedCurvature == .none) {
                  withoutCurvature = true
                  return
                }
                
                if (isTwoStepsNotSelected) {
                  withoutSteps = true
                  return
                }
                
                guard let productValue = currencyManagerBR.doubleValue
                else { return }
                if (productValue <= 0) {
                  withoutTotalValue = true
                  return
                }
                
                result =
                Double(String(format: "%.2f", (productValue / (daysNumber / 30)))) ?? 0.0
                
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
          } content: {
            SheetView(isPresented: $shouldPresentSheet, selectedCurvature: $selectedCurvature, result: $result, hydrate: $hydrateSelected, nutrition: $nutritionSelected, restoration: $restorationSelected, initialDate: $initialDate)
          }
          
        }
        Spacer()
      }
      .alert("Preencha a curvatura", isPresented: $withoutCurvature, actions: {
              Button("OK", role: .cancel, action: {
                withoutCurvature.toggle()
              })
            })
      .alert("Escolha ao menos duas etapas do cronograma!", isPresented: $withoutSteps, actions: {
              Button("OK", role: .cancel, action: {
                withoutSteps.toggle()
              })
            })
      .alert("Insira o valor total dos produtos!", isPresented: $withoutTotalValue, actions: {
              Button("OK", role: .cancel, action: {
                withoutTotalValue.toggle()
              })
            })
      .navigationBarHidden(true)
      .scrollDismissesKeyboard(.immediately)
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
  
  var isTwoStepsNotSelected: Bool {
    let trueCount = [hydrateSelected, nutritionSelected, restorationSelected].filter { $0 }.count
    return trueCount < 2
  }
  
}


#Preview {
  ContentView()
}
