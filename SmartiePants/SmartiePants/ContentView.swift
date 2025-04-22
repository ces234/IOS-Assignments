//
//  ContentView.swift
//  SmartiePants
//
//  Created by Caroline Schafer on 3/6/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionManager

    var body: some View {
        if session.currentUser != nil {
            BottomBarView()
        } else {
            LandingPageView()
        }
    }
}

#Preview {
    ContentView()
}

