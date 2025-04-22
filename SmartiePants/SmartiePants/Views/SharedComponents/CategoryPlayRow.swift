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
                    .font(.poppins(fontStyle: .headline, fontWeight: .medium))
                
                Spacer()
                
                Image(systemName: "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:15, height: 15)
                    .foregroundColor(.lavender)
                
            }.padding(.horizontal, 25.0)
                .padding(.vertical, 20.0)
        }
        .frame(maxWidth: .infinity)
        .background(.lightGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    CategoryPlayRow()
}
