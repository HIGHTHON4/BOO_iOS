import Moya
import Foundation

enum TodayHorrorAPI {
    case getHorror
    case geatHorrorDetail(reportId: String)
}

extension TodayHorrorAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getHorror:
            return "/today-horror"
        case .geatHorrorDetail:
            return "/today-horror/query"
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
        case .geatHorrorDetail(let reportId):
            var parameters: [String: String] = ["reportId": reportId]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return Header.accessToken.header()
        }
    }
}
