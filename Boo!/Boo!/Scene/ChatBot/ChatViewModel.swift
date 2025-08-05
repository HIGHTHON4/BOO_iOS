import SwiftUI
import Moya

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    @Published var currentMessage: String = ""
    @Published var hasStartedChat: Bool = false
    @Published var botInformation: BotInformation
    @Published var reportId: String?

    private let provider = MoyaProvider<ChatAPI>()

    init(botInformation: BotInformation, reportId: String) {
        self.botInformation = botInformation
        self.reportId = reportId
    }

    func startChat() {
        isLoading = true
        provider.request(.start(aiId: botInformation.id)) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                do {
                    let id = try JSONDecoder().decode(String.self, from: response.data)
                    self.reportId = id.replacingOccurrences(of: "\"", with: "")
                    self.hasStartedChat = true
                    print("✅ 채팅 시작 reportId: \(self.reportId!)")
                } catch {
                    print("❌ reportId 디코딩 실패: \(error)")
                }

            case .failure(let error):
                print("❌ 채팅 시작 API 실패: \(error)")
            }
        }
    }

    func stopChat(completion: ((Result<Void, Error>) -> Void)? = nil) {
        provider.request(.stop(reportId: reportId ?? "")) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.resetChat()
                    completion?(.success(()))
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
            }
        }
    }

    func sendMessage(_ text: String) {
        guard let reportId else {
            print("❌ 아직 reportId가 없습니다. startChat() 먼저 호출하세요.")
            return
        }
        hasStartedChat = true
        let userMessage = Message(content: text, isUser: true)
        messages.append(userMessage)
        currentMessage = ""
        isLoading = true

        provider.request(.chat(text: text, reportId: reportId)) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                do {
                    let botReply = try JSONDecoder().decode(ChatMessage.self, from: response.data)
                    let botMessage = Message(content: botReply.content, isUser: false)
                    self.messages.append(botMessage)
                } catch {
                    print("❌ 응답 디코딩 실패: \(error)")
                }

            case .failure(let error):
                print("❌ 메시지 전송 실패: \(error)")
            }
        }
    }

    func resetChat() {
        messages.removeAll()
        isLoading = false
        currentMessage = ""
        hasStartedChat = false
        reportId = nil
    }
}
