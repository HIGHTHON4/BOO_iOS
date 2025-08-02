import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gradit1, .gradit2]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            logoView()
        }
    }
}

#Preview {
    LaunchView()
}
