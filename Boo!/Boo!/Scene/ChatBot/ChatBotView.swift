import SwiftUI

struct ChatBotView: View {
    @StateObject private var viewModel: ChatViewModel
    @Environment(\.isTabBarHidden) var isTabBarHidden
    
    let botInformation: BotInformation
    let reportId: String

    init(botInformation: BotInformation? = nil, reportId: String? = nil) {
        let defaultInfo = BotInformation(
            name: "Boo!",
            image: "boo",
            description: "지금, 말하고 싶은 게 있어서 온 거지?\n무서웠던 일… 말해줄래?\n내가 잘 들어줄게.",
            placeholder: "조용히 들어줄게. 그러니까… 천천히 말해줘",
            id: UUID().uuidString
        )
        let resolvedBot = botInformation ?? defaultInfo
        let resolvedReportId = reportId ?? UUID().uuidString  // 여기서 기본 reportId 부여 가능

        self.botInformation = resolvedBot
        self.reportId = resolvedReportId
        _viewModel = StateObject(wrappedValue: ChatViewModel(botInformation: resolvedBot, reportId: resolvedReportId))
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
