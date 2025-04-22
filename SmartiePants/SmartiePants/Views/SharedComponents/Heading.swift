//
//  Heading.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct Heading: View {
    var headingText = "Test"
    var body: some View {
        VStack(alignment: .center) {
            Text(headingText)
                .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                .foregroundStyle(.lavender)
                .padding(.bottom, -2)
            
            Rectangle()
                .frame(width: 275, height: 2)
        }.padding(.bottom)
    }
}

#Preview {
    Heading()
}
