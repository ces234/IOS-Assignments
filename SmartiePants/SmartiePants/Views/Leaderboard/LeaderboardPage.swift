//
//  LeaderboardPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI
import SwiftData

//struct with attributes needed for each row, but need to pull from actual data
// eventually move to different file
struct UserStats : Identifiable{
    let id = UUID()
    var user:String
    var points:Int
}

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
    /* TODO: Delete */
    var stats = [
        UserStats(user: "Caroline", points: 50000),
        UserStats(user: "Amala", points: 600000),
        UserStats(user: "Username2", points: 20000),
        UserStats(user: "Username3", points: 5),
        UserStats(user: "Zoe", points: 4000)
    ].sorted(by: {$0.points > $1.points})
    
    
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
            
            
            // Display the user data from the data store
            ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                LeaderboardRow(rank: index + 1, user: user.username, points: user.dailyPoints)
            }
            
            
            ForEach(1...stats.count, id: \.self) { index in
                let i = index - 1
                LeaderboardRow(rank: index, user: stats[i].user, points: stats[i].points)
            }
            
            
        }.padding()
        
    }
}

#Preview {
    LeaderboardPage()
}
