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
        Text("Heyy")
            .sheet(isPresented: $isShowingLogin) {
                LoginView(isShowingLogin: $isShowingLogin)
            }
    }
}

#Preview {
    ContentView()
}
