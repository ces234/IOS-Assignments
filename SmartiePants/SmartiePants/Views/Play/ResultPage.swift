//
//  ResultPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 4/9/25.
//

import SwiftUI
import ConfettiSwiftUI

struct ResultPage: View {
    let onReplay: () -> Void
    @Binding var currScore: Int
    @State var difficulty: Difficulty
    @Environment(\.dismiss) var dismiss

    @State private var confettiCounter = 0

    var pointsPerQuestion: Int {
        switch difficulty {
        case .easy:
            return 100
        case .medium:
            return 200
        case .hard:
            return 300
        }
    }

    var totalPoints: Int {
        return currScore * pointsPerQuestion
    }
    
    var body: some View {
        ZStack {
            if currScore <= 3 {
                ForEach(0..<5, id: \.self) { _ in
                    FallingEmoji()
                        .position(
                            x: CGFloat.random(in: 20...UIScreen.main.bounds.width - 20),
                            y: 0
                        )
                }
            }
       
        VStack {
            ConfettiCannon(trigger: $confettiCounter, num: 300, colors: [.blue, .red, .green, .yellow, .pink, .purple, .orange], openingAngle:.degrees(30), closingAngle: .degrees(150), repetitions: 1, repetitionInterval: 1)

            Text("Results")
                .font(.poppins(fontStyle: .title, fontWeight: .bold))
                .font(.title)
                .foregroundStyle(.darkBlue)
                .padding(.bottom)

            Text("\(currScore) / 10 Answers Correct")
                .padding(.bottom, 5)
                .font(.poppins(fontStyle: .title3, fontWeight: .medium))

            Text("Points Earned: \(totalPoints)")
                .font(.poppins(fontStyle: .title3, fontWeight: .medium))

            HStack {
                Button {
                    onReplay()
                } label: {
                    HStack {
                        Text("Replay")
                            .font(.poppins(fontStyle: .callout, fontWeight: .semibold))
                            .foregroundStyle(Color.white)

                        Image(systemName: "memories")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                .background(.darkBlue)
                .clipShape(.rect(cornerRadius: 10))

                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Finish")
                            .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                .background(.lightGray)
                .clipShape(.rect(cornerRadius: 10))
            }
            .padding(.top)
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(false) // so it doesn’t block button taps
        }.onAppear() {
            if currScore > 3 {
                confettiCounter += 1
            }
        }
    }
}

#Preview {
    @Previewable @State var currScore = 5

    ResultPage(onReplay: {}, currScore: $currScore, difficulty: .easy)
}
