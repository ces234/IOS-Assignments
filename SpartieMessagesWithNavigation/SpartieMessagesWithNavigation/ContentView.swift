//
//  ContentView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Caroline Schafer on 2/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingLogin = true
    
    var body: some View {
        MainScreen(contacts: [
            Contact(firstName: "D'Andre", lastName: "Swift", isFavorite: true, picture: "DAndreSwift", messages: [Message(message: "I <3 Da Bears")]),
            Contact(firstName: "Taylor", lastName: "Swift", isFavorite: true, picture: "TaylorSwift", messages: [Message(message: "I am a SWIFTie")]),
            Contact(firstName: "Jeremy", lastName: "Swift", isFavorite: false, picture: "JeremySwift", messages: [Message(message: "Hello Jeremy")])]
        )
            .sheet(isPresented: $isShowingLogin) {
                LoginView(isShowingLogin: $isShowingLogin)
            }
    }
}

#Preview {
    ContentView()
}
