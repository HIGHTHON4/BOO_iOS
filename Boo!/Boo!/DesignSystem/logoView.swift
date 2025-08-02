import SwiftUI

struct logoView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image("logo")
                Image("logoText")
            }
            .padding(18)
            Text("당신만의 공포 해소 챗봇, Boo!")
                .font(.pretendard(.bold, size: 16))
                .foregroundStyle(.white)
                .bold()
        }
    }
}

#Preview {
    logoView()
        .background(Color.black)
}
