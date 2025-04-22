import SwiftUI

struct CountdownTimerView: View {
    var totalTime: TimeInterval = 10
    @State private var remainingTime: TimeInterval
    @Binding var timerRunning: Bool
    @Binding var isTimerFinished: Bool
    
    @State private var timer: Timer?

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
                Circle()
                    .stroke(lineWidth: 6)
                    .opacity(0.3)
                    .foregroundColor(.lightGray)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        remainingTime < 4 ? Color.red : .lavender,
                        style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.01), value: progress)

                Text(String(format: "%.f", max(0, remainingTime)))
                    .font(.poppins(fontStyle: .title2, fontWeight: .semibold))
                    .foregroundColor(remainingTime < 4 ? Color.red : Color.black)
            }
            .frame(width: 50, height: 50)
        }
        .onAppear {
            if timerRunning {
                startTimer()
            }
        }
        .onChange(of: timerRunning) { running in
            if running {
                remainingTime = totalTime
                isTimerFinished = false
                startTimer()
            } else {
                stopTimer()
            }
        }
    }

    func startTimer() {
        stopTimer() // stop any existing timer first

        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 0.01
            } else {
                timer.invalidate()
                self.timer = nil
                isTimerFinished = true
                timerRunning = false
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}


#Preview {
    @Previewable @State var isFinished = false
    @Previewable @State var isRunning = false
    
    CountdownTimerView( isTimerFinished: $isFinished, timerRunning: $isRunning)
}
