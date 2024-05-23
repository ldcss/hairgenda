//
//  CalendarView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 20/05/24.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
  var calendarIdentifier: Calendar.Identifier = .gregorian
  
  @Binding var hydrate: Bool
  @Binding var nutrition: Bool
  @Binding var restoration: Bool
  @Binding var selectedCurvature: Curvature
  @Binding var initialDate: Date
  
  var dateInterval: DateInterval {
    let calendar = Calendar(identifier: calendarIdentifier)
    guard
      let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.month, .year], from: Date())),
      let firstDayOfNextMonth = calendar.date(byAdding: .month, value: 1, to: firstDayOfMonth),
      let lastDayOfMonth = calendar.date(byAdding: .day, value: -1, to: firstDayOfNextMonth)
    else { return DateInterval() }
    return DateInterval(start: firstDayOfMonth, end: lastDayOfMonth)
  }
  
  func makeCoordinator() -> CalendarCoordinator {
    CalendarCoordinator(calendarIdentifier: calendarIdentifier, hydrate: self.hydrate, nutrition: self.nutrition, restoration: self.restoration, selectedCurvature: self.selectedCurvature, initialDate: self.initialDate)
  }
  
  func makeUIView(context: Context) -> UICalendarView {
    
    let view = UICalendarView()
    view.availableDateRange = dateInterval
    view.calendar = Calendar(identifier: calendarIdentifier)
    view.delegate = context.coordinator
    view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return view
  }
  
  func updateUIView(_ uiView: UICalendarView, context: Context) {
    let calendar = Calendar(identifier: calendarIdentifier)
    uiView.calendar = calendar
    uiView.availableDateRange = dateInterval
    context.coordinator.calendarIdentifier = calendarIdentifier
    var components = Set<DateComponents>()
    uiView.reloadDecorations(forDateComponents: Array(components), animated: true)
  }
}

final class CalendarCoordinator: NSObject, UICalendarViewDelegate {
  var calendarIdentifier: Calendar.Identifier
  
  var canSelect: Bool = false
  var hydrate: Bool
  var nutrition: Bool
  var restoration: Bool
  
  var initialDate: Date
  
  var indexToDays: Int = 0
  
  var currentDate: Date = Date.now
  
  var selectedCurvature: Curvature
  
  var calendar: Calendar {
    Calendar(identifier: calendarIdentifier)
  }
  
  
  init(calendarIdentifier: Calendar.Identifier, hydrate: Bool, nutrition: Bool, restoration: Bool, selectedCurvature: Curvature, initialDate: Date) {
    self.calendarIdentifier = calendarIdentifier
    self.hydrate = hydrate
    self.nutrition = nutrition
    self.restoration = restoration
    self.selectedCurvature = selectedCurvature
    self.initialDate = initialDate
  }
  
  func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
    guard let date = calendar.date(from:dateComponents)
    else { return nil }
    
    let month = calendar.component(.month, from: date)
    
    if month != calendar.component(.month, from: currentDate){
      return nil
    }
    
    if calendar.component(.day, from: date) % intervalDays != moduleComputed || calendar.component(.day, from: date) < calendar.component(.day, from: initialDate) {
      return nil
    }
    
    if daysPerSteps[indexDaysPerSteps][indexToDays] == "H" {
      indexToDays += 1
      return .default(color: .lightPink, size: .large)
    } else if daysPerSteps[indexDaysPerSteps][indexToDays] == "R" {
      indexToDays += 1
      return .default(color: .lightBlue, size: .large)
    } else if daysPerSteps[indexDaysPerSteps][indexToDays] == "N" {
      indexToDays += 1
      return .default(color: .lightGreen, size: .large)
    }
    return nil
  }
  
  var daysPerSteps: [[String]] {
    if (hydrate == true && nutrition == true && restoration == true) { // a cada 2 dias
      
      return [["H", "N", "H", "H", "R", "H", "H", "N", "H", "H", "R"],
              ["H", "N", "H", "N", "H", "N", "H", "R", "H", "N", "R"],
              ["H", "N", "H", "H", "N", "R", "H", "N", "H", "N", "H"]]
    } else if (hydrate == true && nutrition == true) { // a cada 3 dias
      
      return [["H", "N", "H", "N", "H", "N", "H", "N", "H"],
              ["H", "N", "H", "N", "H", "N", "H", "N", "H"],
              ["H", "N", "H", "N", "H", "N", "H", "N", "H"]]
    } else if (hydrate == true && restoration == true) { // a cada 6 dias
      
      return [["H", "R", "H", "H", "R"],
              ["H", "R", "H", "H", "R"],
              ["H", "R", "H", "H", "R"]]
      
    } else { //nutrition and restauration // a cada 6 dias
      return [["N", "R", "N", "N", "R"],
              ["N", "R", "N", "N", "R"],
              ["N", "R", "N", "N", "R"]]
    }
  }
  
  var indexDaysPerSteps: Int {
    switch selectedCurvature { // acesses daysPerSteps[indexDaysPerSteps][indexToDays]
    case .one, .none:
      return 0
    case .two, .twoB, .twoC, .threeA, .threeB:
      return 1
    case .threeC, .fourA, .fourB, .fourC:
      return 2
    }
  }
  
  var intervalDays: Int {
    if (hydrate == true && nutrition == true && restoration == true) { // a cada 2 dias
      
      return 3 // day % 3 == 1
    } else if (hydrate == true && nutrition == true) { // a cada 3 dias
      
      return 4 // day % 4 == 1
    } else if (hydrate == true && restoration == true) { // a cada 6 dias
      
      return 7 // day % 7 == 1
      
    } else { //nutrition and restauration -> a cada 6 dias
      
      return 7 // day % 7 == 1
    }
  }
  
  var moduleComputed: Int {
    return calendar.component(.day, from: initialDate) % intervalDays
  }
}

//#Preview {
//  CalendarView(canSelect: <#Bool#>, selectedDate: <#Binding<Date?>#>)
//}
