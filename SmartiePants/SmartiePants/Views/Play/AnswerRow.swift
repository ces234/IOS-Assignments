//
//  AnswerRow.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/29/25.
//

import SwiftUI

struct AnswerRow: View {
    var answerText = "answer"
    var isCorrect = true
    var showAnswer = false
    
    func borderColor() -> Color {
        if isCorrect && showAnswer {
            return Color.green
        } else if !isCorrect && showAnswer {
            return Color.red
        } else {
            return .lightGray
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(answerText)
                    .font(.poppins(fontStyle: .body, fontWeight: .regular))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                                
            }.padding(.vertical, 20.0)
            
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(borderColor(), lineWidth: 3)
        )
        .background(.lightGray)       
    }
}

#Preview {
    AnswerRow(isCorrect: true, showAnswer: false)
}
