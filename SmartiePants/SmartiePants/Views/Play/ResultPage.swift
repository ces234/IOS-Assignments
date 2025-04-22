//
//  ResultPage.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 4/9/25.
//

import SwiftUI

struct ResultPage: View {
    let onReplay: () -> Void
    @Binding var currScore: Int
    @State var difficulty: Difficulty
    @Environment(\.dismiss) var dismiss


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
        VStack {
            Text("Results")
                .font(.title)
                .bold()
                .padding(.bottom)

            Text("\(currScore) / 10 Answers Correct")
                .padding(.bottom, 5)
                .font(.title3)
                .fontWeight(.medium)

            Text("Points Earned: \(totalPoints)")
                .font(.title3)
                .fontWeight(.medium)

            HStack {
                Button {
                    onReplay()
                } label: {
                    HStack {
                        Text("Replay")
                            .font(.callout)
                            .fontWeight(.semibold)
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
                .background(Color(red: 0.4, green: 0.4, blue: 0.4))
                .clipShape(.rect(cornerRadius: 10))

                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Finish")
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(cornerRadius: 10))
            }
            .padding(.top)
        }
    }
}
