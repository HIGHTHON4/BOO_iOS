import SwiftUI

struct ContentView: View {
    
    @State private var isLaunch: Bool = true
    
    var body: some View {
        
        if isLaunch {
            LaunchView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.linear) {
                            self.isLaunch = false
                        }
                    }
                }
        } else {
            Text("Launch Screen 예제 앱")
                .font(.largeTitle)
                .fontWeight(.black)
        }
    }
}

#Preview {
    ContentView()
}
