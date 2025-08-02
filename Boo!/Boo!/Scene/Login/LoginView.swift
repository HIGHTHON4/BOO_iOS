import SwiftUI

struct LoginView: View {

    @State var idText = ""
    @State var pwText = ""

    var body: some View {
        BackgroundWrapper {
            VStack(spacing: 60) {
                logoView()
                VStack(spacing: 20) {
                    VStack(spacing: 8) {
                        AuthTextField(placeholder: "아이디", text: $idText)
                        AuthTextField(placeholder: "비밀번호", text: $pwText,isSecure: true)
                    }
                    Button {
                        print("로그인버튼 클릭")
                    } label: {
                        Text("로그인")
                            .font(.pretendard(.medium, size: 14))
                            .foregroundStyle(.whiteBoo)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(.blue)
                            .cornerRadius(100)
                            .padding(.horizontal, 20)
                    }
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
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    LoginView()
}
