//
//  FallingEmoji.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 4/22/25.
//

import SwiftUI

struct FallingEmoji: View {
    @State private var yOffset = CGFloat.random(in: -300...(-100))
    @State private var opacity: Double = 1.0
    
    let delay: Double = 0.3
    
    var body: some View {
        Text(["😢", "💭", "❓", "😕", "😭", "🥶"].randomElement()!)
                    .font(.system(size: 40))
                    .opacity(opacity)
                    .offset(y: yOffset)
                    .onAppear {
                        withAnimation(.easeIn(duration: 4).delay(delay)) {
                            yOffset = 600
                            opacity = 0.0
                        }
                    }
    }
}


#Preview {
    FallingEmoji()
}
