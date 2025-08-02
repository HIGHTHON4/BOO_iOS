import Foundation
import Moya

class RecordViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var reportDetail: ReportDetail?

    func getMyReports(sort: String, ai: [String]) {
        let provider = MoyaProvider<ReportAPI>(plugins: [MoyaLoggingPlugin()])
        provider.request(.getMyReports(sort: sort, ai: ai)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode([Report].self, from: response.data)
                    DispatchQueue.main.async {
                        self.reports = data
                    }
                } catch {
                    print("Decoding error:", error)
                }
            case .failure(let error):
                print("Network error:", error)
            }
        }
    }

    func getReportDetail(reportId: String, completion: @escaping (ReportDetail?) -> Void) {
        let provider = MoyaProvider<ReportAPI>(plugins: [MoyaLoggingPlugin()])
        provider.request(.getReportDetail(reportId: reportId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let detail = try decoder.decode(ReportDetail.self, from: response.data)
                    DispatchQueue.main.async {
                        self.reportDetail = detail
                        completion(detail)
                    }
                } catch {
                    print("Detail decoding error:", error)
                    completion(nil)
                }
            case .failure(let error):
                print("Network error:", error)
                completion(nil)
            }
        }
    }
}
