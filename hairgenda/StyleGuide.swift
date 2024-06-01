//
//  StyleGuide.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 15/05/24.
//

import SwiftUI

extension Font {
  static let display: Font = .system(
    size: 48,
    weight: .bold,
    design: .rounded
  )
  static let header1: Font = .system(
    size: 40,
    weight: .regular,
    design: .rounded
  )
  static let header2: Font = .system(
    size: 32,
    weight: .regular,
    design: .rounded
  )
  static let header3: Font = .system(
    size: 24,
    weight: .regular,
    design: .rounded
  )
  static let header4: Font = .system(
    size: 20,
    weight: .regular,
    design: .rounded
  )
  static let body1: Font = .body.bold()
}
