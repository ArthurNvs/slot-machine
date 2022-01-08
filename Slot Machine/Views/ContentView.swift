//
//  ContentView.swift
//  Slot Machine
//
//  Created by Arthur Neves on 10/12/21.
//

import SwiftUI

struct ContentView: View {
  let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
  
  @State private var reels = [0, 1, 2]
  @State private var showingInfoView = false
  
  // MARK: - FUNCTIONS
  
  func spinReels() {
    //reels[0] = Int.random(in: 0...symbols.count - 1)
    //reels[1] = Int.random(in: 0...symbols.count - 1)
    //reels[2] = Int.random(in: 0...symbols.count - 1)
    
    reels = reels.map({ _ in
      Int.random(in: 0...symbols.count - 1)
    })
  }
  
  func checkWinning() {
    if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
      // PLAYER WINS
      
      // NEW HIGH SCORE
    } else {
      // PLAYER LOSE
    }
  }
  
  // GAME IS OVER
  
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
            Image(symbols[reels[0]])
              .resizable()
              .modifier(ImageModifier())
          } // ZStack
          
          HStack(alignment: .center, spacing: 0) {
            // MARK: - REEL #2
            ZStack {
              ReelView()
              Image(symbols[reels[1]])
                .resizable()
                .modifier(ImageModifier())
            } // ZStack
            
            Spacer()
            
            // MARK: - REEL #3
            ZStack {
              ReelView()
              Image(symbols[reels[2]])
                .resizable()
                .modifier(ImageModifier())
            } // ZStack
          }
          .frame(maxWidth: 500)
          
          // MARK: - SPIN BUTTON
          Button(action: {
            self.spinReels()
            
            self.checkWinning()
          }, label: {
            Image("gfx-spin")
              .renderingMode(.original)
              .resizable()
              .modifier(ImageModifier())
          })
        } // Slot Machine
        .layoutPriority(2)
        
        Spacer()
        
        // MARK: - FOOTER
        HStack {
          // MARK: - BET 20
          HStack(alignment: .center, spacing: 10) {
            Button(action: {
              print("Bet 20 coins")
            }) {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
            
            Image("gfx-casino-chips")
              .resizable()
              .opacity(0)
              .modifier(CasinoChipsModifier())
          }
          
          // MARK: - BET 10
          HStack(alignment: .center, spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .opacity(1)
              .modifier(CasinoChipsModifier())
            
            Button(action: {
              print("Bet 10 coins")
            }) {
              Text("10")
                .fontWeight(.heavy)
                .foregroundColor(Color.yellow)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
          }
        }
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
          self.showingInfoView = true
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
    .sheet(isPresented: $showingInfoView) {
      InfoView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
