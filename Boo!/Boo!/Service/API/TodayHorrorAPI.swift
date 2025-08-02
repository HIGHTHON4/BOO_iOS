import Moya
import Foundation

enum TodayHorrorAPI {
    case getHorror
}

extension TodayHorrorAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getHorror:
            return "/today-horror"
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
        case .getHorror:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return Header.accessToken.header()
        }
    }
}
