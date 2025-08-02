import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradit1, .gradit2]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
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
}

#Preview {
    LaunchView()
}
