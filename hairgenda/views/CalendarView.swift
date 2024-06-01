//
//  CalendarView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 20/05/24.
//

import SwiftUI

struct DateWithDecoration {
  var date: Date
  var decoration: UICalendarView.Decoration
}

struct CalendarView: UIViewRepresentable {
  var calendarIdentifier: Calendar.Identifier = .gregorian
  
  @Binding var hydrate: Bool
  @Binding var nutrition: Bool
  @Binding var restoration: Bool
  @Binding var selectedCurvature: Curvature
  @Binding var initialDate: Date
  @Binding var finishedDate: Date
  
  func makeCoordinator() -> CalendarCoordinator {
    CalendarCoordinator(calendarIdentifier: calendarIdentifier, hydrate: self.hydrate, nutrition: self.nutrition, restoration: self.restoration, selectedCurvature: self.selectedCurvature, initialDate: self.initialDate, finishedDate: self.finishedDate)
  }
  
  func makeUIView(context: Context) -> UICalendarView {
    let view = UICalendarView()
    view.availableDateRange = DateInterval(start: initialDate, end: finishedDate)
    view.calendar = Calendar(identifier: calendarIdentifier)
    view.delegate = context.coordinator
    view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return view
  }
  
  func updateUIView(_ uiView: UICalendarView, context: Context) {
    let calendar = Calendar(identifier: calendarIdentifier)
    uiView.calendar = calendar
    uiView.availableDateRange = DateInterval(start: initialDate, end: finishedDate)
    context.coordinator.calendarIdentifier = calendarIdentifier
    let components = Set<DateComponents>()
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
  var finishedDate: Date
  var indexToDays: Int = 0
  var currentDate: Date = Date.now
  var selectedCurvature: Curvature
  var calendar: Calendar {
    Calendar(identifier: calendarIdentifier)
  }
  
  init(calendarIdentifier: Calendar.Identifier, hydrate: Bool, nutrition: Bool, restoration: Bool, selectedCurvature: Curvature, initialDate: Date, finishedDate: Date) {
    self.calendarIdentifier = calendarIdentifier
    self.hydrate = hydrate
    self.nutrition = nutrition
    self.restoration = restoration
    self.selectedCurvature = selectedCurvature
    self.initialDate = initialDate
    self.finishedDate = finishedDate
  }
  
  func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
    guard let date = calendar.date(from:dateComponents)
    else {
      return nil
    }
    let calendar = Calendar.current
    let startOfDateToCheck = calendar.startOfDay(for: date)
    
    return decorationByDay(for: startOfDateToCheck)
  }
  
  func decorationByDay(for date: Date) -> UICalendarView.Decoration? {
    let calendar = Calendar.current
    let startOfDayDate = calendar.startOfDay(for: date)
    for dateWithDecoration in cronogramSteps {
      let startOfDayDecorationDate = calendar.startOfDay(for: dateWithDecoration.date)
      if startOfDayDate == startOfDayDecorationDate {
        return dateWithDecoration.decoration
      }
    }
    return nil
  }
  
  func getDatesWithInterval(initialDate: Date, finishDate: Date, interval: Int) -> [DateWithDecoration] {
    indexToDays = 0
    var dates: [DateWithDecoration] = []
    var currentDate = calendar.startOfDay(for: initialDate)
    
    // Calendar instance to perform date calculations
    let calendar = Calendar.current
    
    // Loop through dates from initialDate to finishDate
    while currentDate <= finishDate {
      dates.append(DateWithDecoration(date: currentDate, decoration: self.getDecorationForDate()))
      // Add the interval to the current date
      if let nextDate = calendar.date(byAdding: .day, value: interval, to: currentDate) {
        currentDate = nextDate
      } else {
        break
      }
    }
    
    return dates
  }
  
  func getDecorationForDate() -> UICalendarView.Decoration {
    if daysPerSteps[indexDaysPerSteps][indexToDays % daysPerSteps[indexDaysPerSteps].count] == "H" {
      indexToDays += 1
      return .default(color: .lightPink, size: .large)
      
    } else if daysPerSteps[indexDaysPerSteps][indexToDays % daysPerSteps[indexDaysPerSteps].count] == "R" {
      indexToDays += 1
      return .default(color: .lightBlue, size: .large)
      
    } else if daysPerSteps[indexDaysPerSteps][indexToDays % daysPerSteps[indexDaysPerSteps].count] == "N" {
      indexToDays += 1
      return .default(color: .lightGreen, size: .large)
      
    }
    return .default(color: .white, size: .large)
  }
  
  var daysPerSteps: [[String]] {
    if (hydrate == true && nutrition == true && restoration == true) { // a cada 2 dias
      
      return [["H", "N", "H", "H", "R", "H", "H", "N", "H", "H", "R", "H", "N", "H"],
              ["H", "N", "H", "N", "H", "N", "H", "R", "H", "N", "R", "H", "N", "H"],
              ["H", "N", "H", "H", "N", "H", "R", "N", "H", "N", "H", "H", "N", "H"]]
    } else if (hydrate == true && nutrition == true) { // a cada 2 dias
      
      return [["H", "N", "H", "N", "H", "N", "H", "N", "H"],
              ["H", "N", "H", "N", "H", "N", "H", "N", "H"],
              ["H", "N", "H", "N", "H", "N", "H", "N", "H"]]
    } else if (hydrate == true && restoration == true) { // a cada 2 dias
      
      return [["H", "H", "H", "H", "H", "R"],
              ["H", "H", "H", "H", "H", "R"],
              ["H", "H", "H", "H", "H", "R", "H", "H", "H", "H", "H"]]
      
    } else { //nutrition and restauration // a cada 6 dias
      return [["N", "N", "N", "N", "N", "R"],
              ["N", "N", "N", "N", "N", "R"],
              ["N", "N", "N", "N", "N", "R", "N", "N", "N", "N", "N"]]
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
      
      return 2 // day % 2 == 1
    } else if (hydrate == true && nutrition == true) { // a cada 3 dias
      
      return 2 // day % 4 == 1
    } else if (hydrate == true && restoration == true) { // a cada 6 dias
      
      return 3 // day % 7 == 1
      
    } else { //nutrition and restauration -> a cada 6 dias
      
      return 3 // day % 7 == 1
    }
  }
  
  var cronogramSteps: [DateWithDecoration] {
    return getDatesWithInterval(initialDate: initialDate, finishDate: finishedDate, interval: intervalDays)
  }
}

//#Preview {
//  CalendarView(canSelect: <#Bool#>, selectedDate: <#Binding<Date?>#>)
//}
