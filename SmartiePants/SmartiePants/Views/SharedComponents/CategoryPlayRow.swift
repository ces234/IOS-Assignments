//
//  CategoryPlayRow.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct CategoryPlayRow: View {
    var category = "Category"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category)
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:15, height: 15)
                    .foregroundColor(Color.black)
                
            }.padding(.horizontal, 25.0)
                .padding(.vertical, 20.0)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    CategoryPlayRow()
}
