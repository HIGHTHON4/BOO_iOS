import SwiftUI

struct AuthTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.whiteBoo.opacity(0.3))
                    .font(.pretendard(.medium, size: 14))
                    .padding(.horizontal, 20)
            }

            Group {
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                }
            }
            .frame(height: 45)
            .padding(.horizontal, 20)
            .background(.whiteBoo.opacity(0.1))
            .cornerRadius(100)
            .font(.pretendard(.medium, size: 14))
            .foregroundStyle(.whiteBoo)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    @Previewable @State var sampleText = ""
    return AuthTextField(placeholder: "아이디", text: $sampleText)
}
