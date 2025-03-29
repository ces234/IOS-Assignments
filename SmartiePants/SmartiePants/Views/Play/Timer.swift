import SwiftUI

struct CountdownTimerView: View {
    var totalTime: TimeInterval = 10 // Total countdown duration in seconds
    @State private var remainingTime: TimeInterval = 10
    @Binding var timerRunning: Bool
    @Binding var isTimerFinished: Bool
    
    init(totalTime: TimeInterval = 10, isTimerFinished: Binding<Bool>, timerRunning: Binding<Bool>) {
        self.totalTime = totalTime
        _remainingTime = State(initialValue: totalTime)
        _isTimerFinished = isTimerFinished
        _timerRunning = timerRunning
    }

    var progress: Double {
        return remainingTime / totalTime
    }

    var body: some View {
        VStack {
            ZStack {
                // Background Circle
                Circle()
                    .stroke(lineWidth: 6)
                    .opacity(0.3)
                    .foregroundColor(.gray)

                // Progress Circle
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        remainingTime < 4 ? Color.red : Color.gray,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Rotate to start from top
                    .animation(.linear(duration: 0.01), value: progress)

                // Countdown Text
                Text(String(format: "%.f", remainingTime < 0 ? 0 : remainingTime))
                    .font(.title2)
                    .bold()
                    .foregroundColor(remainingTime < 4 ? Color.red : Color.black)
            }
            .frame(width: 50, height: 50)
        }
        .onAppear {
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if timerRunning {
                if remainingTime > 0 {
                    remainingTime -= 0.01
                } else {
                    timer.invalidate() // Stop the timer at zero
                    isTimerFinished = true
                }
            }
           
        }
    }
}

#Preview {
    @Previewable @State var isFinished = false
    @Previewable @State var isRunning = false
    
    CountdownTimerView( isTimerFinished: $isFinished, timerRunning: $isRunning)
}
