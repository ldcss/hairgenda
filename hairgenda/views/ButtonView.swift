//
//  ButtonView.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 27/05/24.
//

import SwiftUI

struct ButtonView: View {
  var text: String
  var action: () -> Void
  var body: some View {
    Button(action: self.action, label: {
      Text(text)
        .font(.system(size: 18, weight: .bold, design: .rounded))
        .padding()
        .background(Color.brownButton)
        .foregroundStyle(Color.backgroundApp)
        .clipShape(RoundedRectangle(cornerRadius:14))
    })
  }
}

#Preview {
  ButtonView(text: "Teste", action: {
  })
}
