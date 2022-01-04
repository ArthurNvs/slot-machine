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
          VStack(alignment: .center, spacing: 0) {
            // MARK: - REEL #1
            ZStack {
              ReelView()
              Image("gfx-bell")
                .resizable()
                .modifier(ImageModifier())
            } // ZStack
            
            HStack(alignment: .center, spacing: 0) {
              // MARK: - REEL #2
              ZStack {
                ReelView()
                Image("gfx-seven")
                  .resizable()
                  .modifier(ImageModifier())
              } // ZStack
              
              Spacer()
              
              // MARK: - REEL #3
              ZStack {
                ReelView()
                Image("gfx-cherry")
                  .resizable()
                  .modifier(ImageModifier())
              } // ZStack
            }
            .frame(maxWidth: 500)
            
            // MARK: - SPIN BUTTON
            Button(action: {
              print("Spin the reels")
            }, label: {
              Image("gfx-spin")
                .renderingMode(.original)
                .resizable()
                .modifier(ImageModifier())
            })
          } // Slot Machine
          .layoutPriority(2)
          
          // MARK: - FOOTER
          HStack {
            // MARK: - BET 20
            Button(action: {
              print("Bet 20 coins")
            }) {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .font(.system(.title, design: .rounded))
                .padding(.vertical, 5)
                .frame(width: 90)
                .shadow(color: Color("ColorTransparentBlack"), radius: 0, x: 0, y: 3)
            }
            .background(
              Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom))
            )
            .padding(3)
            .background(
              Capsule()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .bottom, endPoint: .top))
            )
          }
          
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
