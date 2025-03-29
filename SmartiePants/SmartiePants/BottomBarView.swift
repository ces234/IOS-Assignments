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
            appearance.backgroundColor = UIColor.gray
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
}
