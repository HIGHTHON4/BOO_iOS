import SwiftUI

// 초기 화면 (채팅 시작 전)
struct InitialChatView: View {
    let botInformation: BotInformation
    
    var body: some View {
        VStack {
            Text("Boo! 와의 채팅")
                .font(.pretendard(.light, size: 15))
                .foregroundStyle(.whiteBoo)
                .padding(.top, 11)
            
            Image(botInformation.image)
                .padding(.top, 40)
            
            Text(botInformation.description)
                .font(.pretendard(.light, size: 16))
                .foregroundStyle(.gray2)
                .multilineTextAlignment(.center)
                .padding(.top, 16)
                .padding(.horizontal, 20)
        }
        .padding(.bottom, 20)
    }
}
