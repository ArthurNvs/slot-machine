//
//  ContentView.swift
//  Slot Machine
//
//  Created by Arthur Neves on 10/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        // MARK: - BACKGROUND
        LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        
        // MARK: - INTERFACE
        VStack(alignment: .center, spacing: 5) {
          // MARK: - HEADER
          LogoView()
          
          // MARK: - SCORE
          // MARK: - FOOTER
        }
        
        // MARK: - POPUP
      } // ZStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
