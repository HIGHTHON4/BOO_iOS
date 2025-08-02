import SwiftUI

struct logoView: View {
    var body: some View {
        VStack {
            Image("logo")
                .padding(20)
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
