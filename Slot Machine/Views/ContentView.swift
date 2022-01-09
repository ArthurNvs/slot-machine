//
//  ContentView.swift
//  Slot Machine
//
//  Created by Arthur Neves on 10/12/21.
//

import SwiftUI

struct ContentView: View {
  let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
  
  let haptics = UINotificationFeedbackGenerator()
  
  @State private var highscore = UserDefaults.standard.integer(forKey: "HighScore")
  @State private var coins = 100
  @State private var betAmount = 10
  @State private var reels = [0, 1, 2]
  @State private var showingInfoView = false
  @State private var isActiveBet10 = true
  @State private var isActiveBet20 = false
  @State private var showingModal = false
  @State private var animatingSymbol = false
  @State private var animatingModal = false
  
  // MARK: - FUNCTIONS
  func spinReels() {
    //reels[0] = Int.random(in: 0...symbols.count - 1)
    //reels[1] = Int.random(in: 0...symbols.count - 1)
    //reels[2] = Int.random(in: 0...symbols.count - 1)
    
    reels = reels.map({ _ in
      Int.random(in: 0...symbols.count - 1)
    })
    playSound(sound: "spin", type: "mp3")
    haptics.notificationOccurred(.success)
  }
  
  func checkWinning() {
    if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
      playerWins()
      newHighScore()
      
      if coins > highscore {
        newHighScore()
      } else {
        playSound(sound: "win", type: "mp3")
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
    UserDefaults.standard.set(highscore, forKey: "HighScore")
    playSound(sound: "high-score", type: "mp3")
  }
  
  func playerLoses() {
    coins -= betAmount
  }
  
  func activateBet20() {
    betAmount = 20
    isActiveBet20 = true
    isActiveBet10 = false
    playSound(sound: "casino-chips", type: "mp3")
    haptics.notificationOccurred(.success)
  }
  
  func activateBet10() {
    betAmount = 10
    isActiveBet10 = true
    isActiveBet20 = false
    playSound(sound: "casino-chips", type: "mp3")
    haptics.notificationOccurred(.success)
  }
  
  func isGameOver() {
    if coins <= 0 {
      showingModal = true
      playSound(sound: "game-over", type: "mp3")
    }
  }
  
  func resetGame() {
    UserDefaults.standard.set(0, forKey: "HighScore")
    highscore = 0
    coins = 100
    activateBet10()
    playSound(sound: "chimeup", type: "mp3")
  }
  
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
              .opacity(animatingSymbol ? 1 : 0)
              .offset(y: animatingSymbol ? 0 : -50)
              .animation(.easeOut(duration: Double.random(in: 0.5...0.7)), value: animatingSymbol)
              .onAppear(perform: {
                self.animatingSymbol.toggle()
                playSound(sound: "riseup", type: "mp3")
              })
          } // ZStack
          
          HStack(alignment: .center, spacing: 0) {
            // MARK: - REEL #2
            ZStack {
              ReelView()
              Image(symbols[reels[1]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.5...0.9)), value: animatingSymbol)
                .onAppear(perform: {
                  self.animatingSymbol.toggle()
                })
            } // ZStack
            
            Spacer()
            
            // MARK: - REEL #3
            ZStack {
              ReelView()
              Image(symbols[reels[2]])
                .resizable()
                .modifier(ImageModifier())
                .opacity(animatingSymbol ? 1 : 0)
                .offset(y: animatingSymbol ? 0 : -50)
                .animation(.easeOut(duration: Double.random(in: 0.9...1.5)), value: animatingSymbol)
                .onAppear(perform: {
                  self.animatingSymbol.toggle()
                })
            } // ZStack
          }
          .frame(maxWidth: 500)
          
          // MARK: - SPIN BUTTON
          Button(action: {
            // 1. Set default state: no animation
            withAnimation {
              self.animatingSymbol = false
            }
            
            // 2. Spin the reels changing symbols
            self.spinReels()
            
            // 3. Trigger animation after changing symbols
            withAnimation {
              self.animatingSymbol = true
            }
            
            // 4. Check Winning
            self.checkWinning()
            
            
            // 5. Game is over
            self.isGameOver()
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
              .offset(x: isActiveBet20 ? 0 : 20)
              .opacity(isActiveBet20 ? 1 : 0)
              .modifier(CasinoChipsModifier())
          }
          
          Spacer()
          
          // MARK: - BET 10
          HStack(alignment: .center, spacing: 10) {
            Image("gfx-casino-chips")
              .resizable()
              .offset(x: isActiveBet10 ? 0 : -20)
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
          self.resetGame()
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
      .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
      
      // MARK: - POPUP
      if $showingModal.wrappedValue {
        ZStack {
          Color("CollorTransparentBlack").edgesIgnoringSafeArea(.all)
          
          // MODAL
          VStack(spacing: 0) {
            Text("GAME OVER")
              .font(.system(.title, design: .rounded))
              .fontWeight(.heavy)
              .padding()
              .frame(minWidth: 0, maxWidth: .infinity)
              .background(Color("ColorPink"))
              .foregroundColor(Color.white)
            
            Spacer()
            
            // MESSAGE
            VStack(alignment: .center, spacing: 16) {
              Image("gfx-seven-reel")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 72)
              
              Text("Bad luck! No more coins....")
                .font(.system(.body, design: .rounded))
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray)
                .layoutPriority(1)
              
              Button(action: {
                self.showingModal = false
                self.animatingModal = false
                self.activateBet10()
                self.coins = 100
              }) {
                Text("New Game".uppercased())
                  .font(.system(.body, design: .rounded))
                  .fontWeight(.semibold)
                  .accentColor(Color("ColorPink"))
                  .padding(.horizontal, 12)
                  .padding(.vertical, 8)
                  .frame(minWidth: 128)
                  .background(
                    Capsule()
                      .strokeBorder(lineWidth: 1.75)
                      .foregroundColor(Color("ColorPink"))
                  )
              }
            }
            
            Spacer()
          }.frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
            .opacity($animatingModal.wrappedValue ? 1 : 0)
            .offset(y: $animatingModal.wrappedValue ? 0 : -100)
            .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0), value: animatingModal)
            .onAppear(perform: {
              self.animatingModal = true
            })
        }
      }
    } // ZStack
    .sheet(isPresented: $showingInfoView) {
      InfoView()
    }
  }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
