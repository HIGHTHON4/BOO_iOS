import SwiftUI

struct ChatMessagesView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var isShowingEndSheet = false
    @State private var shouldNavigateToReport = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        BackgroundWrapper{
            VStack(spacing: 0) {
                HStack {
                    Text("Boo! 와의 채팅")
                        .font(.pretendard(.light, size: 15))
                        .foregroundStyle(.whiteBoo)
                        .padding(.top, 11)
                        .padding(.bottom, 20)
                    Spacer()
                    Button {
                        isShowingEndSheet = true
                    } label: {
                        Text("대화 종료하기")
                            .font(.pretendard(.light, size: 10))
                            .foregroundStyle(.whiteBoo)
                            .frame(width: 92, height: 28)
                            .background(.sodomy4)
                            .cornerRadius(5)
                    }
                }
                .padding(.horizontal, 20)
                
                // 채팅 메시지 영역
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.messages) { message in
                                MessageBubbleView(message: message)
                                    .id(message.id)
                            }
                            
                            if viewModel.isLoading {
                                LoadingMessageView()
                                    .id("loading")
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if let lastMessage = viewModel.messages.last {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .onChange(of: viewModel.isLoading) { isLoading in
                        if isLoading {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                proxy.scrollTo("loading", anchor: .bottom)
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingEndSheet) {
                EndChatSheetView {
                    isShowingEndSheet = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        // ReportView로 가는 게 아니라 그냥 pop 하기
                        dismiss()
                    }
                }
                .presentationDetents([.height(290)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}

