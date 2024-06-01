//
//  ContentView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 15/05/24.
//

import SwiftUI

struct ContentView: View {
  @State private var selectedCurvature: Curvature = .none
  @State private var showPicker: Bool = false
  @State var shouldPresentSheet = false
  @State private var showImage: Bool = false
  @State private var initialDate: Date = Date()
  @State private var finishedDate: Date = Date()
  @State private var hydrateSelected:Bool = false
  @State private var nutritionSelected:Bool = false
  @State private var restorationSelected:Bool = false
  @State var withoutCurvature = false
  @State var withoutSteps = false
  
  func getDatesWithInterval(initialDate: Date, finishDate: Date, interval: Int) -> [Date] {
    var dates: [Date] = []
    var currentDate = initialDate
    
    // Calendar instance to perform date calculations
    let calendar = Calendar.current
    
    // Loop through dates from initialDate to finishDate
    while currentDate <= finishDate {
      dates.append(currentDate)
      // Add the interval to the current date
      if let nextDate = calendar.date(byAdding: .day, value: interval, to: currentDate) {
        currentDate = nextDate
      } else {
        break
      }
    }
    
    return dates
  }
  
  var body: some View {
    NavigationStack {
      ZStack{
        Color.backgroundApp.ignoresSafeArea()
        
        VStack{
          HStack{
            Spacer()
            Text("HairGenda").font(.display).frame(maxHeight: 50)
            Spacer()
          }
          ScrollView{
            VStack(spacing: 8){
              
              VStack(alignment: .leading, spacing: 32) {
                
                VStack(alignment: .leading, spacing: 16) {
                  
                  VStack{
                    Spacer()
                  }.frame(height:24)
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
                CustomDatePickerView(text: "Início do cronograma", date: $initialDate)
                
                CustomDatePickerView(text: "Fim do cronograma", date: $finishedDate)
                
                
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
                
                Spacer()
                HStack{
                  Spacer()
                  ButtonView(text: "Calcular Cronograma"){
                    
                    if (isTwoStepsNotSelected) {
                      withoutSteps = true
                      return
                    }
                    
                    if (selectedCurvature == .none) {
                      withoutCurvature = true
                      return
                    }
                    
                    
                    shouldPresentSheet.toggle()
                  }
                  Spacer()
                }
                Spacer()
              }
              .padding()
              .sheet(isPresented: $shouldPresentSheet) {
              } content: {
                SheetView(isPresented: $shouldPresentSheet, selectedCurvature: $selectedCurvature, hydrate: $hydrateSelected, nutrition: $nutritionSelected, restoration: $restorationSelected, initialDate: $initialDate, finishedDate: $finishedDate)
                  .background(Color.backgroundApp.edgesIgnoringSafeArea(.all))
                  .presentationDetents([.large])
                  .presentationCornerRadius(21)
              }
              
            }
            Spacer()
          }
          .alert("Preencha a sua curvatura!", isPresented: $withoutCurvature, actions: {
            Button("OK", role: .cancel, action: {
              withoutCurvature.toggle()
            })
          })
          .alert("Escolha ao menos duas etapas do cronograma!", isPresented: $withoutSteps, actions: {
            Button("OK", role: .cancel, action: {
              withoutSteps.toggle()
            })
          })
          .navigationBarHidden(true)
          .scrollDismissesKeyboard(.immediately)
        }
      }
      
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
