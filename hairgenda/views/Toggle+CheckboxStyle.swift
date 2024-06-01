//
//  Toggle+CheckboxStyle.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 22/05/24.
//

import Foundation
import SwiftUI

struct ToggleCheckboxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      Image(systemName: "checkmark.square")
        .symbolVariant(configuration.isOn ? .fill : .none)
    }
  }
}

extension ToggleStyle where Self == ToggleCheckboxStyle {
  static var checklist: ToggleCheckboxStyle { .init() }
}
