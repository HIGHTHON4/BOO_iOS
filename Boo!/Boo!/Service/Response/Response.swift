import Foundation

struct BotIntroduction: Identifiable {
    var name: String
    var description: String
    var image: String
    var id: String
}

struct BotInformation: Identifiable {
    var image: String
    var description: String
    var placeholder: String
    var id: String
}
extension BotIntroduction {
    func toBotInformation() -> BotInformation {
        return BotInformation(
            image: self.image,
            description: self.description,
            placeholder: "조용히 들어줄게. 그러니까… 천천히 말해줘", 
            id: self.id
        )
    }
}

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date = Date()
}
