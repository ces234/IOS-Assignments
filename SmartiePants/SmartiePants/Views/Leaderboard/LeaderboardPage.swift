//
//  LeaderboardPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI
import SwiftData

enum PointsCategory : String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case totalPoints
    // ADD MORE HERE
    
    var displayName: String {
        switch self {
        case .totalPoints:
            return "Total Points"
        }
    }
    
}

struct LeaderboardPage: View {
    
    @Query(sort: \User.dailyPoints, order: .reverse) var users: [User]
    
    @State var pointsSorter:PointsCategory = .totalPoints
    
    var body: some View {
        ScrollView {
            Heading(headingText: "Daily Leaderboard")
            
            /* TODO: Figure out how to style this */
            VStack {
                Picker("Points Selector", selection: $pointsSorter) {
                    ForEach(PointsCategory.allCases) { category in
                        Text(category.displayName)
                            .foregroundStyle(Color.white)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                    }
                }
                .foregroundStyle(Color.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                
            }
            
            ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                LeaderboardRow(rank: index + 1, user: user.username, points: user.dailyPoints)
            }
        }.padding()
        
    }
}

#Preview {
    LeaderboardPage()
}
