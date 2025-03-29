//
//  Heading.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct Heading: View {
    var headingText = ""
    var body: some View {
        VStack(alignment: .center) {
            Text(headingText)
                .font(.title2)
                .bold()
            
            Rectangle()
                .frame(width: 275, height: 2)
        }.padding(.bottom)
    }
}

#Preview {
    Heading()
}
