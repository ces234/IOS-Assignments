//
//  HomePageView.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack(alignment: .leading) {

            VStack(alignment: .leading) {
                Text("Welcome back,")
                    .font(.title2)
                Text("Caroline") //REPLACE WITH USER'S NAME PASSED IN
                    .font(.title)
                    .bold()
                
                Rectangle()
                    .frame(width: 250, height: 3)
                
            }
            
            HStack {
                HStack {
                    Image(systemName: "trophy")
                        .resizable()
                        .scaledToFit()
                        .frame(width:50, height: 50)
                        .foregroundColor(Color.white)
                        
                    VStack(alignment: .leading) {
                        Text("Rank:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Text("5 / 123")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                }.padding()
                
                                
                HStack {
                    Image(systemName: "star.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width:48, height: 48)
                        .foregroundColor(Color.white)
                        
                    VStack(alignment: .leading) {
                        Text("Points:")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Text("6000")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                    }
                }.padding(25.0)
                
            }
            .background(Color.gray)
            .clipShape(.rect(cornerRadius: 15))
            .padding()
            
            
            VStack(alignment: .leading) {
                Text("History")
                    .font(.title2)
                    .fontWeight(.bold)
                
                List {
                    Text("Daily Streak")
                        .bold()
                    
                    Text("Daily Points Record")
                        .bold()
                    
                    VStack {
                        Text("Top Categories")
                            .bold()
                        
                        /* MAKE THIS A FOR EACH AND PULL TOP CATEGORIES */
                        Text("Sports")
                            .font(.callout)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(.rect(cornerRadius: 5))
                        
                    }
                   
                }
                .listStyle(.inset)
                .scrollDisabled(true)
            }
            
            /* PULL RECENT CATEGORIES */
            VStack(alignment: .leading) {
                Text("Recent Categories")
                    .font(.title2)
                    .fontWeight(.bold)
                
                List {
                   // CHANGE THIS TO RECENT CATEGORIES BOX
                    
                }
                .listStyle(.inset)
                .scrollDisabled(true)
            }
           
            
        }
        .padding()
        
    }
}

#Preview {
    HomePageView()
}
