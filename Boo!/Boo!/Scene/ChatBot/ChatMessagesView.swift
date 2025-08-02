import SwiftUI
import Moya

struct ChatMessagesView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var isShowingEndSheet = false
    @Environment(\.dismiss) private var dismiss
    private let ChatProvider = MoyaProvider<ChatAPI>(plugins: [MoyaLoggingPlugin()])

    var body: some View {
        BackgroundWrapper {
            VStack(spacing: 0) {
                headerView

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            messageListView
                            loadingIndicatorView
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        scrollToLast(proxy: proxy)
                    }
                    .onChange(of: viewModel.isLoading) { isLoading in
                        if isLoading {
                            scrollToLoading(proxy: proxy)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingEndSheet) {
                EndChatSheetView {
                    isShowingEndSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        dismiss()
                    }
                }
                .presentationDetents([.height(290)])
                .presentationDragIndicator(.visible)
            }
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        HStack {
            Text("\(viewModel.botInformation.name) 와의 채팅")
                .font(.pretendard(.light, size: 15))
                .foregroundStyle(.whiteBoo)
                .padding(.top, 11)
                .padding(.bottom, 20)

            Spacer()

            Button {
                viewModel.stopChat { result in
                    switch result {
                    case .success:
                        isShowingEndSheet = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            dismiss()
                        }
                    case .failure(let error):
                        print("대화 종료 실패: \(error)")
                    }
                }
            } label: {
                Text("대화 종료하기")
                    .font(.pretendard(.light, size: 10))
                    .foregroundStyle(.whiteBoo)
                    .frame(width: 92, height: 28)
                    .background(Color.sodomy4)
                    .cornerRadius(5)
            }
        }
        .padding(.horizontal, 20)
    }

    private var messageListView: some View {
        ForEach(viewModel.messages) { message in
            MessageBubbleView(
                message: message,
                botName: viewModel.botInformation.name
            )
            .id(message.id)
        }
    }

    private var loadingIndicatorView: some View {
        Group {
            if viewModel.isLoading {
                LoadingMessageView()
                    .id("loading")
            }
        }
    }

    // MARK: - Scrolling Helpers

    private func scrollToLast(proxy: ScrollViewProxy) {
        withAnimation(.easeInOut(duration: 0.3)) {
            if let lastMessage = viewModel.messages.last {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }

    private func scrollToLoading(proxy: ScrollViewProxy) {
        withAnimation(.easeInOut(duration: 0.3)) {
            proxy.scrollTo("loading", anchor: .bottom)
        }
    }
}
