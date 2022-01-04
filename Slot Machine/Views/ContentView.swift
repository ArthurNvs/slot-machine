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
          
          Spacer()
          
          // MARK: - SCORE
          HStack {
            HStack {
              Text("Your\nCoins".uppercased())
                .scoreLabelStyle()
                .multilineTextAlignment(.trailing)
              
              Text("100")
                .scoreNumberStyle()
                .modifier(ScoreNumberModifier())
            }
            .modifier(ScoreContainerModifier())
            
            Spacer()
            
            HStack {
              Text("200")
                .scoreNumberStyle()
                .modifier(ScoreNumberModifier())
              
              Text("Your\nCoins".uppercased())
                .scoreLabelStyle()
                .multilineTextAlignment(.leading)
            }
            .modifier(ScoreContainerModifier())
          }
          
          // MARK: - SLOT MACHINE
          // MARK: - FOOTER
          
          Spacer()
        }
        // MARK: - BUTTONS
        .overlay(
         // RESET
          Button(action: {
            print("Reset the Game")
          }, label: {
            Image(systemName: "arrow.2.circlepath.circle")
          }) // Button
          .modifier(ButtonModifier()),
          alignment: .topLeading
        )
        .overlay(
         // INFO
          Button(action: {
            print("Info View")
          }, label: {
            Image(systemName: "info.circle")
          }) // Button
          .modifier(ButtonModifier()),
          alignment: .topTrailing
        )
        .padding()
        .frame(maxWidth: 720)
        
        // MARK: - POPUP
      } // ZStack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
