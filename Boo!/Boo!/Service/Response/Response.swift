import Foundation

struct AccessToken: Codable {
    let accessToken: String
}

struct ChatMessage: Codable {
    let content: String
}

struct BotIntroduction: Identifiable, Codable, Hashable {
    var name: String
    var description: String
    var image: String
    var id: String
}

struct BotInformation: Identifiable {
    var name: String
    var image: String
    var description: String
    var placeholder: String
    var id: String
}
extension BotIntroduction {
    func toBotInformation() -> BotInformation {
        return BotInformation(
            name: self.name,
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

struct Report: Decodable {
    var reportId: String
    let level: String?
    let date: String
    let title: String
    
    // level이 객체나 다른 형태로 올 경우를 대비한 custom decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reportId = try container.decode(String.self, forKey: .reportId)
        date = try container.decode(String.self, forKey: .date)
        title = try container.decode(String.self, forKey: .title)
        
        // level 처리 - 문자열이거나 객체일 수 있음
        if let levelString = try? container.decode(String.self, forKey: .level) {
            level = levelString
        } else {
            // level이 객체인 경우 nil로 처리하거나 다른 로직 추가
            level = nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case reportId, level, date, title
    }
}

struct ReportDetail: Decodable {
    let title: String
    let fearLevel: String
    let summary: String
}
