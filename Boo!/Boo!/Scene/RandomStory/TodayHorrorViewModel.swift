import Combine
import Foundation
import Moya

class TodayHorrorViewModel: ObservableObject {
    @Published var stories: [TodayHorror] = []
    
    private let provider = MoyaProvider<TodayHorrorAPI>(plugins: [MoyaLoggingPlugin()])
    
    func fetchStories() {
        provider.request(.getHorror) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode([TodayHorror].self, from: response.data)
                    DispatchQueue.main.async {
                        self?.stories = data
                    }
                } catch {
                    print("Decoding error:", error)
                }
            case .failure(let error):
                print("Network error:", error)
            }
        }
    }

    func fetchHorrorDetail(reportId: String, completion: @escaping (HorrorDetail?) -> Void) {
        provider.request(.geatHorrorDetail(reportId: reportId)) { result in
            switch result {
            case .success(let response):
                do {
                    let detail = try JSONDecoder().decode(HorrorDetail.self, from: response.data)
                    completion(detail)
                } catch {
                    print("Detail decoding error:", error)
                    completion(nil)
                }
            case .failure(let error):
                print("Detail network error:", error)
                completion(nil)
            }
        }
    }
}
