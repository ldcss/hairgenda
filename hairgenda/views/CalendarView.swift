//
//  CalendarView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 20/05/24.
//

import SwiftUI

struct CalendarView: UIViewRepresentable {
  var calendarIdentifier: Calendar.Identifier = .gregorian
  var canSelect: Bool = false
  @Binding var hydrateDate: Date
  @Binding var nutritionDate: Date
  @Binding var restorationDate: Date
  
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
    CalendarCoordinator(calendarIdentifier: calendarIdentifier, canSelect: canSelect, hydrateDate: hydrateDate, nutritionDate: nutritionDate, restorationDate: restorationDate)
  }
  
  func makeUIView(context: Context) -> UICalendarView {
    print("MAKE UI VIEW")
    let view = UICalendarView()
    view.availableDateRange = dateInterval
    view.calendar = Calendar(identifier: calendarIdentifier)
    if canSelect {
      view.selectionBehavior = UICalendarSelectionSingleDate(delegate: context.coordinator)
    }
    view.delegate = context.coordinator
    view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return view
  }
  
  func updateUIView(_ uiView: UICalendarView, context: Context) {
    print("UPDATE UI VIEW!")
    let calendar = Calendar(identifier: calendarIdentifier)
    uiView.calendar = calendar
    uiView.availableDateRange = dateInterval
    context.coordinator.calendarIdentifier = calendarIdentifier
    var components = Set<DateComponents>()
    components.insert(calendar.dateComponents([.month, .day, .year], from: hydrateDate))
    components.insert(calendar.dateComponents([.month, .day, .year], from: nutritionDate))
    components.insert(calendar.dateComponents([.month, .day, .year], from: restorationDate))
    //    print("components", components)
    context.coordinator.hydrateDate = hydrateDate
    context.coordinator.nutritionDate = nutritionDate
    context.coordinator.restorationDate = restorationDate
    uiView.reloadDecorations(forDateComponents: Array(components), animated: true)
    //
  }
}

final class CalendarCoordinator: NSObject, UICalendarSelectionSingleDateDelegate, UICalendarViewDelegate {
  var calendarIdentifier: Calendar.Identifier
  var canSelect: Bool = false
  var hydrateDate: Date
  var nutritionDate: Date
  var restorationDate: Date
  var calendar: Calendar {
    Calendar(identifier: calendarIdentifier)
  }
  
  init(calendarIdentifier: Calendar.Identifier, canSelect:Bool, hydrateDate: Date, nutritionDate: Date, restorationDate: Date) {
    self.calendarIdentifier = calendarIdentifier
    self.canSelect = canSelect
    self.hydrateDate = hydrateDate
    self.nutritionDate = nutritionDate
    self.restorationDate = restorationDate
  }
  
  func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
    guard let dateComponents,
          let date = calendar.date(from: dateComponents)
    else { return false }
    return !calendar.isDateInWeekend(date)
  }
  
  func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
    guard let dateComponents,
          let date = calendar.date(from: dateComponents)
    else { return }
  }
  
  func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
    let date = calendar.date(from:dateComponents)
//    print("DATE", date)
    //    print("hydrate", hydrateDate)
    //    print("nutrition", nutritionDate)
    //    print("restoration", restorationDate)
    
    guard let actualDate = calendar.date(from: dateComponents)
    else {return nil}
    
    if calendar.isDate(actualDate, equalTo: hydrateDate, toGranularity: .day){
      return .default(color: .lightPink, size: .large)
    }
    
    else if calendar.isDate(actualDate, equalTo: restorationDate, toGranularity: .day){
      return .default(color: .lightGreen, size: .large)
    }
    
    else if calendar.isDate(actualDate, equalTo: nutritionDate, toGranularity: .day){
      return .default(color: .lightBlue, size: .large)
    }
    
    else {
      return nil
    }
  
  }
}

//#Preview {
//  CalendarView(canSelect: <#Bool#>, selectedDate: <#Binding<Date?>#>)
//}
