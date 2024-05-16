//
//  Curvatures.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 15/05/24.
//

import Foundation

enum Curvature: String, CaseIterable, Identifiable {
  var id: Self { self }
  
  case none = "Selecionar"
  case one = "1"
  case two = "2A"
  case twoB = "2B"
  case twoC = "2C"
  case threeA = "3A"
  case threeB = "3B"
  case threeC = "3C"
  case fourA = "4A"
  case fourB = "4B"
  case fourC = "4C"
}
