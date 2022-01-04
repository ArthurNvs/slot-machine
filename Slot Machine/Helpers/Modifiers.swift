//
//  Modifiers.swift
//  Slot Machine
//
//  Created by Arthur Neves on 04/01/22.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 6)
  }
}
