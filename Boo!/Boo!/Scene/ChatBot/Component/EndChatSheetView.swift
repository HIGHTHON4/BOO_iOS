import SwiftUI

struct EndChatSheetView: View {
    var onConfirm: () -> Void

    var body: some View {
        ZStack {
            Color.sodomy5
                .ignoresSafeArea()

            VStack(spacing: 40) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("대화를 종료하시겠습니까?")
                        .font(.pretendard(.bold, size: 20))
                        .foregroundStyle(.whiteBoo)
                        .padding(.top, 50)

                    Text(
                        """
챗봇과의 대화가 종료되면, 나눈 대화를 바탕으로 AI가 괴담 리포트를 작성해줍니다.

괴담 리포트에서는 AI가 남긴 괴담 코멘트와 공포 등급을 확인할 수 있습니다.

생성된 리포트는 ‘챗봇 기록' 탭에서 확인 가능합니다.
"""
                    )
                    .font(.pretendard(.light, size: 14))
                    .foregroundStyle(.whiteBoo)
                    .fixedSize(horizontal: false, vertical: true)
                }

                Button {
                    onConfirm() // ✅ 종료 로직 위임
                } label: {
                    Text("대화 종료하기")
                        .font(.pretendard(.bold, size: 16))
                        .foregroundStyle(.whiteBoo)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(.blue)
                        .cornerRadius(100)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
}
