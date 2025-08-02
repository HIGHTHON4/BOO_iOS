import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var isLoading: Bool = false
    @Published var currentMessage: String = ""
    @Published var hasStartedChat: Bool = false
    
    let botInformation: BotInformation
    
    init(botInformation: BotInformation) {
        self.botInformation = botInformation
    }
    
    func sendMessage(_ text: String) {
        if !hasStartedChat {
            hasStartedChat = true
        }
        
        let userMessage = Message(content: text, isUser: true)
        messages.append(userMessage)
        currentMessage = ""
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let botResponse = self.generateBotResponse(for: text)
            let botMessage = Message(content: botResponse, isUser: false)
            self.messages.append(botMessage)
            self.isLoading = false
        }
    }
    
    func resetChat() {
        messages.removeAll()
        isLoading = false
        currentMessage = ""
        hasStartedChat = false
    }
    
    private func generateBotResponse(for userMessage: String) -> String {
        let responses = [
            "그렇구나... 천천히 말해줘서 고마워.",
            "엘리베이터가 망실한 관리 숨이 막힐 뻔 했지. 계단가 온자것다... 그 숨길, 너 정말 많이 놀랐겠다.",
            "힘들었겠어... 나도 그런 경험이 있어.",
            "괜찮아, 이제 안전한 곳이야.",
            "천천히 얘기해도 돼. 급하지 않으니까."
        ]
        return responses.randomElement() ?? "응답을 생각하고 있어..."
    }
}
