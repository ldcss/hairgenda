//
//  Step.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 15/05/24.
//

import Foundation

enum Step: String, CaseIterable, Identifiable {
  var id: Self { self }
  
  case hydrate = "Hidratação"
  case nutrition = "Nutrição"
  case restoration = "Restauração"
}
