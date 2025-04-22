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
            
            VStack(alignment: .leading, spacing: 15) {
//                Menu {
//                    Picker(selection: $pointsSorter) {
//                        ForEach(PointsCategory.allCases) { category in
//                            Text(category.displayName)
//                                .font(.poppins(fontStyle: .body, fontWeight: .regular))
//                                .background(RoundedRectangle(cornerRadius: 16).fill(.lightGray))
//                        }
//                    } label: {}
//                } label: {
//                    HStack {
//                        Text("\(pointsSorter.displayName)")
//                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
//                            .foregroundStyle(.white)
//                            .padding(.trailing, 5)
//                            
//                        Image(systemName: "chevron.down")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width:15, height: 15)
//                            .foregroundColor(.white)
//                    }
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 20)
//                    .background(RoundedRectangle(cornerRadius: 8).fill(.darkBlue))
//                }
//                .padding(.vertical, 10)
                
                ForEach(Array(users.enumerated()), id: \.element.id) { index, user in
                    LeaderboardRow(rank: index + 1, user: user.username, points: user.dailyPoints)
                }
            }.padding()
            
            
        }.padding()
        
    }
}

#Preview {
    LeaderboardPage()
}
