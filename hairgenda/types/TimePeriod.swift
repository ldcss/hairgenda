//
//  Interval.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 22/05/24.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
  var id: Self { self }
  
  case monthly = "Mensal"
  case semiannually = "Semestral"
  case yearly = "Anual"
}
