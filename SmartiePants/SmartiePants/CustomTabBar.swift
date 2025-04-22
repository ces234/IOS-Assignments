//
//  CustomTabBar.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:32, height: 32)
                }
            }
            .tint(Color.secondary)
            
            Spacer()
            
            Button {
                
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:32, height: 32)
                }
            }
            .tint(Color.primary)
            
            Spacer()
            
            Button {
                
            } label: {
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "chart.bar.xaxis")
                        .resizable()
                        .scaledToFit()
                        .frame(width:32, height: 32)
                }
            }
            .tint(Color.secondary)
            
            Spacer()
        }
        .frame(height: 82)
        
    }
}

#Preview {
    CustomTabBar()
}
