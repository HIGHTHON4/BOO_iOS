import SwiftUI

struct MessageBubbleView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(message.content)
                        .font(.pretendard(.light, size: 14))
                        .foregroundColor(.whiteBoo)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .frame(maxWidth: 250, alignment: .trailing)
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Boo!")
                        .font(.pretendard(.bold, size: 16))
                        .foregroundStyle(.whiteBoo)
                    HStack(alignment: .top, spacing: 12) {
                        Text(message.content)
                            .font(.pretendard(.light, size: 14))
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(.whiteBoo)
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                            .frame(maxWidth: 250, alignment: .leading)
                    }
                }
                
                Spacer()
            }
        }
    }
}
