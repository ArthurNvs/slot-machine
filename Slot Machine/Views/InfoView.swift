//
//  InfoView.swift
//  Slot Machine
//
//  Created by Arthur Neves on 05/01/22.
//

import SwiftUI

struct InfoView: View {
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    VStack(alignment: .center, spacing: 10) {
      LogoView()
      
      Spacer()
      
      Form {
        Section(header: Text("About Slot Machine App")) {
          FormRowView(firstItem: "Application", secondItem: "Slot Machine")
          FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, MacOS")
          FormRowView(firstItem: "Developer", secondItem: "Arthur Neves")
          FormRowView(firstItem: "Designer", secondItem: "Robert Petras")
          FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
          FormRowView(firstItem: "Website", secondItem: "swiftuimasterclass.com")
          FormRowView(firstItem: "Copyright", secondItem: "© 2020 All rights reserved.")
          FormRowView(firstItem: "Version", secondItem: "1.0.0")
        }
      }
      .font(.system(.body, design: .rounded))
    }
    .padding(.top, 40)
    .overlay(
      Button(action: {
        self.presentationMode.wrappedValue.dismiss()
      }) {
        Image(systemName: "xmark.circle")
          .font(.title)
      }
        .padding(.top, 30)
        .padding(.trailing, 20)
        .accentColor(Color.secondary)
      , alignment: .topTrailing
    )
  }
}

struct FormRowView: View {
  var firstItem: String
  var secondItem: String
  var body: some View {
    HStack {
      Text(firstItem).foregroundColor(Color.gray)
      Spacer()
      Text(secondItem)
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
  }
}
