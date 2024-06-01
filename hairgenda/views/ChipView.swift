//
//  ChipView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 22/05/24.
//

import SwiftUI

struct ChipView: View {
  
  let systemImage: String
  let titleKey: LocalizedStringKey
  let tint: Color
  
  var body: some View {
    HStack(spacing: 4) {
      Image.init(systemName: systemImage).font(.body)
        .foregroundColor(tint)
      Text(titleKey)
        .font(.system(size: 16, weight: .regular, design: .rounded))
        .lineLimit(1)
    }
    .padding(.vertical, 4)
    .padding(.leading, 4)
    .padding(.trailing, 10)
    .background(Color.backgroundApp)
    .cornerRadius(20)
    .clipShape(Capsule())
  }
}
//
//#Preview {
//  ChipView(systemImage: <#String#>, titleKey: <#LocalizedStringKey#>, isSelected: <#Bool#>)
//}
