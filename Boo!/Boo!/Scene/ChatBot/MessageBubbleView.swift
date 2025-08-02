import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    let botName: String // 봇 이름
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                
                Text(message.content)
                    .font(.pretendard(.light, size: 14))
                    .foregroundColor(.whiteBoo)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .frame(maxWidth: 250, alignment: .trailing)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text(botName) // 봇 이름 표시
                        .font(.pretendard(.bold, size: 16))
                        .foregroundStyle(.whiteBoo)
                    Text(message.content)
                        .font(.pretendard(.light, size: 14))
                        .foregroundColor(.black)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.whiteBoo)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .frame(maxWidth: 250, alignment: .leading)
                }
                
                Spacer()
            }
        }
    }
}
