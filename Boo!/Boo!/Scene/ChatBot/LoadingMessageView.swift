import SwiftUI

struct LoadingMessageView: View {
    @State private var animationPhase = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 12) {
                    // 로딩 인디케이터 (프로필 이미지 제거)
                    HStack(spacing: 4) {
                        ForEach(0..<3) { index in
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 8, height: 8)
                                .opacity(animationPhase == index ? 1.0 : 0.3)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.whiteBoo)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                            withAnimation(.easeInOut(duration: 0.4)) {
                                animationPhase = (animationPhase + 1) % 3
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}
