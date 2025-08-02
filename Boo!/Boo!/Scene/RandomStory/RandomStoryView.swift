import SwiftUI

struct RandomStoryView: View {
    @StateObject private var viewModel = TodayHorrorViewModel()
    @State private var timeRemaining = 0
    @State private var timer: Timer?

    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 60) {
                    Spacer()
                    VStack {
                        Text("다음 랜덤까지 남은 시간")
                            .font(.pretendard(.light, size: 16))
                            .foregroundColor(.whiteBoo)
                        
                        Text(formatTime(timeRemaining))
                            .font(.system(size: 80, weight: .ultraLight))
                            .foregroundColor(.whiteBoo)
                            .tracking(2)
                    }
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Text("오늘의 랜덤 괴담은?")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        VStack(spacing: 12) {
                            ForEach(Array(viewModel.stories.enumerated()), id: \.element.reportId) { index, story in
                                NavigationLink(destination: StoryDetailView(reportId: story.reportId)) {
                                    HStack {
                                        Text("\(index + 1). \(story.title)")
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
                            if viewModel.stories.isEmpty {
                                Text("로딩 중...")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
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
            viewModel.fetchStories()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // --- 기존 타이머 관련 함수 유지 ---
    private func calculateTimeRemaining() {
        let now = Date()
        let calendar = Calendar.current
        
        var targetComponents = calendar.dateComponents([.year, .month, .day], from: now)
        targetComponents.hour = 4
        targetComponents.minute = 44
        targetComponents.second = 44
        
        guard let targetTime = calendar.date(from: targetComponents) else { return }
        
        let finalTargetTime = targetTime > now ? targetTime : calendar.date(byAdding: .day, value: 1, to: targetTime) ?? targetTime
        
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
                calculateTimeRemaining()
                viewModel.fetchStories() // 시간 리셋 시점에 다시 호출
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
