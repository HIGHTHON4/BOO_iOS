import SwiftUI

struct ContentView: View {
    @State private var isLaunch: Bool = true
    
    var body: some View {
        BackgroundWrapper {
            
            if isLaunch {
                LaunchView()
                    .transition(.opacity)
            } else {
                LoginView()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isLaunch = false
            }
        }
    }
}

#Preview {
    ContentView()
}
