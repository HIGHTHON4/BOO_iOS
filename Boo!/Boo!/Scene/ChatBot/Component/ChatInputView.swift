import SwiftUI

// ChatInputView 수정 - disabled 상태 추가
struct ChatInputView: View {
    @Binding var chat: String
    var placeholder: String
    var isEditMode: Bool = true
    var onSend: (String) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            ZStack(alignment: .leading) {
                if chat.isEmpty {
                    Text(placeholder)
                        .foregroundColor(.whiteBoo.opacity(0.3))
                        .font(.pretendard(.light, size: 14))
                        .padding(.horizontal, 16)
                }
                TextField("", text: $chat)
                    .font(.pretendard(.light, size: 14))
                    .foregroundStyle(.whiteBoo)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .frame(height: 46)
                    .disabled(!isEditMode)
            }
            .background(.sodomy3)
            .cornerRadius(22)
            .opacity(isEditMode ? 1.0 : 0.6)
            
            Button(action: {
                let trimmed = chat.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty && isEditMode else { return }
                onSend(trimmed)
                chat = ""
            }) {
                Image("send")
                    .frame(width: 27, height: 27)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(isEditMode ? Color.black : Color.gray)
                    .clipShape(Circle())
            }
            .disabled(!isEditMode)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 20)
    }
}
