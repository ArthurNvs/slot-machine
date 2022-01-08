//
//  ContentView.swift
//  Slot Machine
//
//  Created by Arthur Neves on 10/12/21.
//

import SwiftUI

struct ContentView: View {
  let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
  
  @State private var highscore = 0
  @State private var coins = 100
  @State private var betAmount = 10
  @State private var reels = [0, 1, 2]
  @State private var showingInfoView = false
  @State private var isActiveBet10 = true
  @State private var isActiveBet20 = false
  
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
      playerWins()
      newHighScore()
      
      if coins > highscore {
        newHighScore()
      }
    } else {
      playerLoses()
    }
  }
  
  func playerWins() {
    coins += betAmount * 10
  }
  
  func newHighScore() {
    highscore = coins
  }
  
  func playerLoses() {
    coins -= betAmount
  }
  
  func activateBet20() {
    betAmount = 20
    isActiveBet20 = true
    isActiveBet10 = false
  }
  
  func activateBet10() {
    betAmount = 10
    isActiveBet10 = true
    isActiveBet20 = false
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
            
            Text("\(coins)")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
          }
          .modifier(ScoreContainerModifier())
          
          Spacer()
          
          HStack {
            Text("\(highscore)")
              .scoreNumberStyle()
              .modifier(ScoreNumberModifier())
            
            Text("High\nScore".uppercased())
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
              self.activateBet20()
            }) {
              Text("20")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
                .modifier(BetNumberModifier())
            }
            .modifier(BetCapsuleModifier())
            
            Image("gfx-casino-chips")
              .resizable()
              .opacity(isActiveBet20 ? 1 : 0)
              .modifier(CasinoChipsModifier())
          }
          
          // MARK: - BET 10
          HStack(alignment: .center, spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .opacity(isActiveBet10 ? 1 : 0)
              .modifier(CasinoChipsModifier())
            
            Button(action: {
              self.activateBet10()
            }) {
              Text("10")
                .fontWeight(.heavy)
                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : Color.white)
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
