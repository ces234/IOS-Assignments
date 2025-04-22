//
//  LeaderboardRow.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct LeaderboardRow: View {
    @State var label:String = "Points Earned"
    var rank = 4 // get from index of ForEach
    var user = "Caroline"
    var points = 1000
    var isCurrentUser = false //pass in to change color if current user
    
    var body: some View {
        VStack {
            if rank == 1 {
                VStack(alignment: .leading) {
                    Text("Smartie Pants of the Day")
                        .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                        .foregroundStyle(.darkBlue)
                        .underline()
                    
                    HStack {
                        Image("first-place")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                        
                        VStack(alignment: .leading) {
                            Text(user)
                                .font(.poppins(fontStyle: .title3, fontWeight: .bold))
                            
                            Text("\(label): \(points)")
                                .font(.poppins(fontStyle: .body, fontWeight: .regular))
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                    }
                }.padding(.horizontal, 30.0)
                    .padding(.vertical, 20.0)
            }
            else if rank == 2 || rank == 3 {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        Image(rank == 2 ? "second-place" : "third-place")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 58, height: 58)
                        
                        VStack(alignment: .leading) {
                            Text(user)
                                .font(.poppins(fontStyle: .title3, fontWeight: .semibold))
                            
                            Text("\(label): \(points)")
                                .font(.poppins(fontStyle: .body, fontWeight: .regular))
                        }
                        .padding(.leading, 10)
                        
                        Spacer()
                        
                    }
                }.padding(.horizontal, 30.0)
                    .padding(.vertical, 20.0)
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(rank).  \(user)")
                            .font(.poppins(fontStyle: .headline, fontWeight: .semibold))
                        
                        Spacer()
                        
                        Text("Points: \(points)")
                            .font(.poppins(fontStyle: .body, fontWeight: .regular))
                        
                    }.padding(.horizontal, 30.0)
                        .padding(.vertical, 20.0)
                }
            }
        } .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.15))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    LeaderboardRow()
}
