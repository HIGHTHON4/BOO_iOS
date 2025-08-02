import SwiftUI
import Moya
import FirebaseMessaging

struct LoginView: View {
    @State var idText = ""
    @State var pwText = ""
    @State private var shouldNavigate = false
    @State private var fcmToken: String?
    
    
    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 60) {
                    logoView()
                    
                    VStack(spacing: 20) {
                        VStack(spacing: 8) {
                            AuthTextField(placeholder: "아이디", text: $idText)
                            AuthTextField(placeholder: "비밀번호", text: $pwText, isSecure: true)
                        }
                        
                        Button(action: {
                            let token = Messaging.messaging().apnsToken
                            login(id: idText, password: pwText, token: fcmToken)
                        }) {
                            Text("로그인")
                        }
                        .font(.pretendard(.medium, size: 14))
                        .foregroundStyle(.whiteBoo)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(.blue)
                        .cornerRadius(100)
                        .padding(.horizontal, 20)
                        
                        HStack(spacing: 6) {
                            Text("만약 계정이 없다면?")
                                .font(.pretendard(.medium, size: 14))
                                .foregroundStyle(.whiteBoo)
                            Text("회원가입")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.blue)
                                .underline()
                        }
                    }
                    
                    NavigationLink(destination: TabbarView(), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                    
                    Spacer()
                }
                .padding(.top, 60)
            }
            .onAppear {
                if let token = Messaging.messaging().fcmToken {
                    self.fcmToken = token
                    print("📲 fcmToken 직접 접근: \(token)")
                }
                
                NotificationCenter.default.addObserver(forName: Notification.Name("FCMToken"), object: nil, queue: .main) { notification in
                    if let token = notification.userInfo?["token"] as? String {
                        self.fcmToken = token
                        print("📩 fcmToken 노티 통해 수신: \(token)")
                    }
                }
            }
        }
    }
    
    func login(id: String, password: String, token: String?) {
        let manager = Session(configuration: .default, serverTrustManager: CustomServerTrustManager())
        let provider = MoyaProvider<AuthAPI>(session: manager, plugins: [MoyaLoggingPlugin()])
        
        provider.request(.login(accountId: id, password: password, deviceToken: token ?? "")) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let decodedData = try JSONDecoder().decode(AccessToken.self, from: response.data)
                        Token.accessToken = decodedData.accessToken
                        print("✅ 로그인 성공: \(response.statusCode)")
                        DispatchQueue.main.async {
                            shouldNavigate = true
                        }
                    } catch {
                        print("❌ 디코딩 실패: \(error)")
                    }
                } else {
                    print("⚠️ 로그인 실패 - 상태 코드: \(response.statusCode)")
                }
                
            case .failure(let error):
                print("❌ 로그인 실패: \(error)")
            }
        }
    }
}

#Preview {
    LoginView()
}

extension Data {
    var hexString: String {
        map { String(format: "%02x", $0) }.joined()
    }
}
