import SwiftUI

struct RandomStoryView: View {
    @State private var timeRemaining = 0
    @State private var timer: Timer?
    
    let stories = [
        "엘리베이터에서 만난 정체불명의 그림자",
        "한 순간의 좋음으로 일어난 사고",
        "매일 내 차례에 놓여있는 커피의 비밀"
    ]
    
    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 60) {
                    Spacer()
                    VStack {
                        // Next random time text
                        Text("다음 랜덤까지 남은 시간")
                            .font(.pretendard(.light, size: 16))
                            .foregroundColor(.whiteBoo)
                        
                        // Timer display
                        Text(formatTime(timeRemaining))
                            .font(.system(size: 80, weight: .ultraLight))
                            .foregroundColor(.whiteBoo)
                            .tracking(2)
                    }
                    Spacer()
                    
                    // Today's random story section
                    VStack(spacing: 20) {
                        Text("오늘의 랜덤 괴담은?")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        VStack(spacing: 12) {
                            ForEach(Array(stories.enumerated()), id: \.offset) { index, story in
                                Button(action: {
                                    // 스토리 선택 액션
                                    print("Selected story: \(story)")
                                }) {
                                    HStack {
                                        Text("\(index + 1). \(story)")
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 16)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white.opacity(0.1))
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Bottom info text
                    Text("괴담은 매일 새벽 4시 44분 44초에 3개씩 공개됩니다.")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .onAppear {
            calculateTimeRemaining()
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func calculateTimeRemaining() {
        let now = Date()
        let calendar = Calendar.current
        
        // 오늘 4시 44분 44초
        var targetComponents = calendar.dateComponents([.year, .month, .day], from: now)
        targetComponents.hour = 4
        targetComponents.minute = 44
        targetComponents.second = 44
        
        guard let targetTime = calendar.date(from: targetComponents) else { return }
        
        // 만약 현재 시간이 이미 4:44:44를 지났다면 다음날 4:44:44로 설정
        let finalTargetTime = targetTime > now ? targetTime : calendar.date(byAdding: .day, value: 1, to: targetTime) ?? targetTime
        
        // 남은 시간 계산
        timeRemaining = max(0, Int(finalTargetTime.timeIntervalSince(now)))
    }
    
    private func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // 4:44:44에 도달했을 때 다음날로 리셋
                calculateTimeRemaining()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

struct RandomStoryView_Previews: PreviewProvider {
    static var previews: some View {
        RandomStoryView()
    }
}
