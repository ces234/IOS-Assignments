//
//  CustomTabBar.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI

enum Tab {
    case home
    case play
    case leaderboard
}

struct CustomTabBar: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        VStack(spacing: 0) {
            // Show selected content
            Group {
                switch selectedTab {
                case .home:
                    HomePageView()
                case .play:
                    PlayGeneralView()
                case .leaderboard:
                    LeaderboardPage()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom oval tab bar
            HStack {
                Spacer()
                tabBarButton(image: "house.fill", tab: .home)
                Spacer()
                Spacer()
                tabBarButton(image: "play.circle.fill", tab: .play)
                Spacer()
                Spacer()
                tabBarButton(image: "chart.bar.xaxis", tab: .leaderboard)
                Spacer()
            }
            .padding()
            .background(Color.slightLightGray)
//            .clipShape(Capsule())
//            .padding(.horizontal, 20)
//            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
        }
//        .edgesIgnoringSafeArea(.bottom)
//        .padding(.bottom, 1)
    }

    @ViewBuilder
    private func tabBarButton(image: String, tab: Tab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36) // bigger icons
                .foregroundColor(selectedTab == tab ? .darkBlue : Color.gray.opacity(0.55))
        }
    }
}


#Preview {
    CustomTabBar()
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
