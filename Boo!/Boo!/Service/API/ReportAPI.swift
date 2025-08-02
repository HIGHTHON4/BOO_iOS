import Moya
import Foundation

enum ReportAPI {
    case getMyReports(sort: String, ai: [String])
    case getReportDetail(reportId: String)
}

extension ReportAPI: TargetType {
    var baseURL: URL {
        return URL(string: Secrets.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMyReports:
            return "/report/my"
        case .getReportDetail:
            return "/report"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .getMyReports(sort, ai):
            // "전체"가 선택된 경우 ai 파라미터를 빈 배열로 보냄
            let aiParams = ai.contains("전체") ? ["1"] : ai
            var parameters: [String: Any] = ["sort": sort]
            
            // ai 파라미터가 있을 때만 추가
            if !aiParams.isEmpty {
                parameters["ai"] = aiParams
            }
            
            print("API 파라미터: \(parameters)") // 디버깅용
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .getReportDetail(reportId):
            var parameters: [String: String] = ["reportId": reportId]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return Header.accessToken.header()
    }
}

