import SwiftUI

struct ChatBotView: View {
    var body: some View {
        BackgroundWrapper {
            Text("ChatBot")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ChatBotView()
}
