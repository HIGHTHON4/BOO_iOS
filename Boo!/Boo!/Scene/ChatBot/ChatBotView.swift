import SwiftUI

struct ChatBotView: View {
    @StateObject private var viewModel: ChatViewModel
    @Environment(\.isTabBarHidden) var isTabBarHidden

    // 초기화할 때 BotInformation을 받도록 수정
    init(botInformation: BotInformation? = nil) {
        let defaultInfo = BotInformation(
            image: "boo",
            description: "지금, 말하고 싶은 게 있어서 온 거지?\n무서웠던 일… 말해줄래?\n내가 잘 들어줄게.",
            placeholder: "조용히 들어줄게. 그러니까… 천천히 말해줘",
            id: UUID().uuidString
        )
        self._viewModel = StateObject(wrappedValue: ChatViewModel(botInformation: botInformation ?? defaultInfo))
    }

    var body: some View {
        BackgroundWrapper {
            VStack(spacing: 0) {
                if !viewModel.hasStartedChat {
                    InitialChatView(botInformation: viewModel.botInformation)
                } else {
                    ChatMessagesView(viewModel: viewModel)
                }

                Spacer()

                ChatInputView(
                    chat: $viewModel.currentMessage,
                    placeholder: viewModel.botInformation.placeholder,
                    onSend: { message in
                        viewModel.sendMessage(message)
                    }
                )
                .disabled(viewModel.isLoading)
            }
            .onAppear {
                isTabBarHidden.wrappedValue = true
            }
            .onDisappear {
                isTabBarHidden.wrappedValue = false
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ChatBotView()
}
