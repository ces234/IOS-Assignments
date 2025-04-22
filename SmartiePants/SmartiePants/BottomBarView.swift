//
//  BottomBarView.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI

struct BottomBarView: View {
    init() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .darkBlue
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundColor(.white)
                        
                }

            PlayGeneralView()
                .tabItem {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.white)
                }
            LeaderboardPage()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis") //medal.fill
                        .foregroundColor(.white)
                }
        }
        .accentColor(.white)
//        .tabBar(
        
    }
}

#Preview {
    BottomBarView()
        .environmentObject({
            let mockSession = SessionManager()
            mockSession.currentUser = User(
                firstName: "Caroline",
                lastName: "Caroline",
                username: "Schafer",
                password: "1234"
            )
            return mockSession
        }())
}
