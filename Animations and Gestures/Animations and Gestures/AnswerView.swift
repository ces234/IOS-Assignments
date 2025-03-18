//
//  AnswerView.swift
//  Animations and Gestures
//
//  Created by Zoe Goldberg on 3/18/25.
//

import SwiftUI

struct AnswerView: View {
    let answer: Answer
    @State var isSelected: Bool = false
    @State private var startAnimation = false
    @State private var showIncorrect: Bool = false
    @State private var showCorrect:Bool = false
    @State private var rotate = -1.0
    let onTap: () -> Void
    
    var body: some View {
        Text(answer.text)
            .frame(maxWidth: .infinity )
            .padding()
            .background(answerBackgroundColor)
            .foregroundColor(.black)
            .clipShape(.capsule)
            .onTapGesture {
                isSelected = true
                if !answer.isCorrect {
                    withAnimation(.default.repeatCount(2).repeatForever(autoreverses: true).speed(5.0)) {
                        showIncorrect = true
                    } completion: {
                        withAnimation(.linear(duration: 0.5).speed(5.0)) {
                            rotate = 1.0
                        } completion: {
                            onTap()
                            showIncorrect = false
                            rotate = -1.0
                        }
                        
                    }
                    
                } else {
                    withAnimation(.linear(duration: 0.5)) {
                        showCorrect = true
                    } completion: {
                        showCorrect = false
                        onTap()
                    }
                }
            }
            .rotationEffect(showIncorrect ? .degrees(10*rotate) : .degrees(0))
            .animation(.default.speed(5.0), value: showIncorrect)
            .scaleEffect(showCorrect ? 100 : 1.0)
            .zIndex(showCorrect ? 5 : 0)
            .animation(.default.speed(1).repeatForever(autoreverses: true), value: showCorrect)
        //            .rotationEffect(.degrees(showIncorrect ? 15 : 0))
//            .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true))
//            .animation(.easeInOut(duration: 0.5), value: isSelected)
//            .phaseAnimator([0, 1, 2], trigger: showIncorrect) { view, phase in
//                view
//                    .scaleEffect(phase == 1 || phase == 2 ? 1.1 : 1)
//                    .rotationEffect(phase == 1 ? .degrees(-15) : .degrees(0))
//                    .rotationEffect(phase == 2 ? .degrees(15) : .degrees(0))
//            }
//            animation: { phase in
//                switch phase {
////                    case 1:
////                        .linear.speed(1.3)
//                    case 2:
//                        .linear.speed(1.3)
//                    default:
//                        .linear
//                }
//                    
//            }
        
    }
    
    private var answerBackgroundColor: Color {
        if isSelected {
            return answer.isCorrect ? Color.green.opacity(1.0) : (showIncorrect ? Color.red : Color.gray.opacity(0.2))
        }
        return Color.gray.opacity(0.2)
    }
}

#Preview {
    AnswerView(answer: Answer(isCorrect: false, text: "3"), isSelected: false, onTap: {})
}
