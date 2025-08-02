import Moya
import Foundation

enum ChatAPI {
    case start(aiId: String)
    case chat(text: String, reportId: String)
    case stop(reportId: String)
}

extension ChatAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .start:
            return "/chat/start"
        case .chat:
            return "/chat"
        case .stop:
            return "/chat/stop"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .start(let aiId):
            return .requestParameters(
                parameters: [
                    "aiId": aiId
                ], encoding: JSONEncoding.default)
        case .chat(let text, let reportId):
            return .requestParameters(
                parameters: [
                    "text": text,
                    "reportId": reportId
                ], encoding: JSONEncoding.default)
        case .stop(let reportId):
            return .requestParameters(
                parameters: [
                    "reportId": reportId
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return Header.accessToken.header()
        }
    }
}
