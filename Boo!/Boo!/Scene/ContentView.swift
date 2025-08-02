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
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
