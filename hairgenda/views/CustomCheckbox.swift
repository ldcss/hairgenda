//
//  CustomCheckbox.swift
//  hairgenda
//
//  Created by Lucas Daniel Costa da Silva on 22/05/24.
//

import SwiftUI

struct CustomCheckbox: View {
  @State var CheckboxLabel: String
  @Binding var isSelected: Bool
  @State var showPopover: Bool = false
  var popoverText: String
  
  var stepColor: Color {
    switch CheckboxLabel {
    case "Hidratação":
      return Color.lightPink
    case "Nutrição":
      return Color.lightGreen
    case "Restauração":
      return Color.lightBlue
    default:
      return Color.black
    }
  }
  
  var body: some View {
    HStack{
      HStack{
        Text(CheckboxLabel)
          .font(.system(size: 20, weight: .semibold, design: .rounded))
        Button {
          showPopover.toggle()
        } label: {
          Image(systemName: "info.circle")
            .tint(stepColor)
        }.popover(isPresented: $showPopover, attachmentAnchor: .point(.trailing), arrowEdge: .bottom, content: {
          Text(popoverText)
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .padding()
            .presentationCompactAdaptation(.popover)
        })
        
        Spacer()
        
        Group {
          Toggle("Select Checkbox", isOn: $isSelected)
            .labelsHidden()
            .toggleStyle(.checklist)
            .font(.title)
            .tint(stepColor)
        }
      }
      HStack{
        Spacer()
      }.frame(maxWidth:50)
    }
    .frame(maxWidth: .infinity)
  }
}

//#Preview {
//  CustomCheckbox(CheckboxLabel: "Hidratação", isSelected: true)
//}
