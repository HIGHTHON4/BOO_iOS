import SwiftUI
import Moya

struct ChatBotSelectView: View {
    @State private var cards: [BotIntroduction] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let AiProvider = MoyaProvider<AiAPI>(plugins: [MoyaLoggingPlugin()])
    private let ChatProvider = MoyaProvider<ChatAPI>(plugins: [MoyaLoggingPlugin()])

    @State private var isChatActive = false
    @State private var selectedBotInfo: BotInformation?
    @State private var reportId: String?

    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 25) {
                    Image("worriedEmoji")
                    Text("오늘 무서운 일이 있었군요.\n어떤 AI와 얘기하며 털어 놓으시겠어요?")
                        .font(.pretendard(.bold, size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)

                    if isLoading {
                        ProgressView()
                    } else if let error = errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(cards) { card in
                                    Button {
                                        startChat(aiId: card.id) { result in
                                            switch result {
                                            case .success(let json):
                                                if let id = json["reportId"] as? String {
                                                    reportId = id
                                                    selectedBotInfo = card.toBotInformation()
                                                    isChatActive = true
                                                } else {
                                                    errorMessage = "reportId가 없습니다."
                                                }
                                            case .failure(let error):
                                                print("채팅 시작 실패: \(error.localizedDescription)")
                                                errorMessage = "채팅 시작에 실패했습니다."
                                            }
                                        }
                                    } label: {
                                        ChatBotIntroduction(
                                            icon: card.image,
                                            name: card.name,
                                            content: card.description
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    fetchBots()
                }

                NavigationLink(
                    destination: Group {
                        if let info = selectedBotInfo, let id = reportId {
                            ChatBotView(botInformation: info, reportId: id)
                        } else {
                            EmptyView()
                        }
                    },
                    isActive: $isChatActive,
                    label: { EmptyView() }
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .navigationBarBackButtonHidden()
    }

    private func fetchBots() {
        isLoading = true
        errorMessage = nil

        AiProvider.request(.ai) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let response):
                    do {
                        let bots = try JSONDecoder().decode([BotIntroduction].self, from: response.data)
                        cards = bots
                    } catch {
                        errorMessage = "파싱 오류: \(error.localizedDescription)"
                    }

                case .failure(let error):
                    errorMessage = "API 호출 실패: \(error.localizedDescription)"
                }
            }
        }
    }

    private func startChat(aiId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        ChatProvider.request(.start(aiId: aiId)) { result in
            switch result {
            case .success(let response):
                do {
                    // 서버가 순수 문자열만 보냄 -> String으로 직접 변환 시도
                    if let reportId = String(data: response.data, encoding: .utf8)?
                        .trimmingCharacters(in: CharacterSet(charactersIn: "\"")) {
                        completion(.success(["reportId": reportId]))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "응답 형식이 올바르지 않습니다."])))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

#Preview {
    ChatBotSelectView()
}
