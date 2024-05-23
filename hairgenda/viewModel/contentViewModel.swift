//
//  contentViewModel.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 22/05/24.
//

import Foundation
import SwiftUI

class ContentViewModel {
  func generateDatesForCurrentMonth(intervalDay: Int) -> [Date]? {
    let calendar = Calendar(identifier: .gregorian)
    
    var dates: [Date] = []
    
    let now = Date()
    
    let currentYear = calendar.component(.year, from: now)
    let currentMonth = calendar.component(.month, from: now)
    
    // Create a DateComponents instance for May 1st, 2024
    var dateComponents = DateComponents()
    dateComponents.year = currentYear
    dateComponents.month = currentMonth
    dateComponents.day = 1
    
    // Create a calendar instance
    
    // Create the start date for May 1st, 2024
    guard let startDate = calendar.date(from: dateComponents) else {
      return nil
    }
    
    // Iterate through the days of May 2024 with a step of 2 days
    var currentDate = startDate
    while let month = calendar.dateComponents([.month], from: currentDate).month, month == currentMonth {
      dates.append(currentDate)
      
      // Add 2 days to the current date
      guard let nextDate = calendar.date(byAdding: .day, value: intervalDay, to: currentDate) else {
        break
      }
      
      currentDate = nextDate
    }
    
    return dates
  }
  
}
