import Moya
import Foundation

enum AuthAPI {
    case login(accountId: String, password: String, deviceToken: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
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
        case .login(let id, let password, let deviceToken):
            return .requestParameters(
                parameters: [
                    "accountId": id,
                    "password": password,
                    "deviceToken": deviceToken,
                    "os": "IOS"
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return Header.tokenIsEmpty.header()
        }
    }
}
