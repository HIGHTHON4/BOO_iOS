import SwiftUI

struct ChatBotSelectView: View {
    @State var cards: [BotIntroduction] = [
        BotIntroduction(
            name: "꼬마 유령 Boo!",
            description: "말수가 적고 따뜻한 공감러 \n감정의 결을 놓치지 않고, 한 얘기에 길게 집중해줌 조용히, 천천히 얘기할 때 추천",
            image: "boo",
            id: UUID().uuidString
        ),
        BotIntroduction(
            name: "꼬마 유령 Boo!",
            description: "말수가 적고 따뜻한 공감러 \n감정의 결을 놓치지 않고, 한 얘기에 길게 집중해줌 조용히, 천천히 얘기할 때 추천",
            image: "boo",
            id: UUID().uuidString
        ),
        BotIntroduction(
            name: "꼬마 유령 Boo!",
            description: "말수가 적고 따뜻한 공감러 \n감정의 결을 놓치지 않고, 한 얘기에 길게 집중해줌 조용히, 천천히 얘기할 때 추천",
            image: "boo",
            id: UUID().uuidString
        ),
        BotIntroduction(
            name: "꼬마 유령 Boo!",
            description: "말수가 적고 따뜻한 공감러 \n감정의 결을 놓치지 않고, 한 얘기에 길게 집중해줌 조용히, 천천히 얘기할 때 추천",
            image: "boo",
            id: UUID().uuidString
        )
    ]
    @State private var shouldNavigateToReport = false
    
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
                    
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(cards, id: \.id) { card in
                                NavigationLink(destination: ChatBotView()) {
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
                .padding()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
}

#Preview {
    ChatBotSelectView()
}
