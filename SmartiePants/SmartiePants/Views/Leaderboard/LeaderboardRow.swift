//
//  LeaderboardRow.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct LeaderboardRow: View {
    /* TODO: Pull from data */
    var rank = 3 // get from index of ForEach
    var user = "Caroline"
    var points = 1000
    var isCurrentUser = false //pass in to change color if current user
    
    var body: some View {
        VStack {
            if rank == 1 {
                VStack(alignment: .center) {
                    Text("Smartie Pants of the Day")
                        .font(.title2)
                        .bold()
                    
                    HStack {
                        Text("\(rank)")
                            .font(.title)
                            .fontWeight(.black)
                            .frame(width: 64, height: 64)
                            .background(Color.yellow) /*TODO: Replace color with gold*/
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading) {
                            
                            Text(user)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Points Earned: \(points)")
                                .font(.body)
                                .fontWeight(.regular)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                    }
                }.padding(.horizontal, 30.0)
                    .padding(.vertical, 20.0)
            }
            else if rank == 2 || rank == 3 {
                VStack(alignment: .center) {
                    HStack {
                        Text("\(rank)")
                            .font(.title)
                            .fontWeight(.black)
                            .frame(width: 64, height: 64)
                            .background(rank == 2 ? Color.gray.opacity(0.5) : Color.brown) /*TODO: Replace color*/
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading) {
                            
                            Text(user)
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Points Earned: \(points)")
                                .font(.body)
                                .fontWeight(.regular)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                    }
                }.padding(.horizontal, 30.0)
                    .padding(.vertical, 20.0)
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(rank).  \(user)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("Points: \(points)")
                            .font(.body)
                            .fontWeight(.regular)
                        
                    }.padding(.horizontal, 30.0)
                        .padding(.vertical, 20.0)
                }
//                .frame(maxWidth: .infinity)
//                .background(Color.gray.opacity(0.15))
//                .clipShape(.rect(cornerRadius: 10))
            }
        } .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.15))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    LeaderboardRow()
}
