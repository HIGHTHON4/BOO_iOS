import Moya
import Foundation

enum AiAPI {
    case ai
}
extension AiAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .ai:
            return "/ai"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .ai:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return Header.accessToken.header()
    }
}
