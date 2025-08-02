import SwiftUI

private struct TabBarVisibilityKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var isTabBarHidden: Binding<Bool> {
        get { self[TabBarVisibilityKey.self] }
        set { self[TabBarVisibilityKey.self] = newValue }
    }
}

struct TabbarView: View {
    @State private var selectedTab = 0
    @State private var isTabbarHidden = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                contentView(for: selectedTab)
                    .environment(\.isTabBarHidden, $isTabbarHidden);                Spacer(minLength: 0)
                if !isTabbarHidden {
                    customTabbar
                }
            }
        }
    }

    private var customTabbar: some View {
        HStack(spacing: 60) {
            tabItem(icon: selectedTab == 0 ? "chatBotSelected" : "chatBot", index: 0, label: "챗봇")
            tabItem(icon: selectedTab == 1 ? "earthSelected" : "earth", index: 1, label: "랜덤 괴담")
            tabItem(icon: selectedTab == 2 ? "recordSelected" : "record", index: 2, label: "챗봇 기록")
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(.gradit2)
    }

    @ViewBuilder
    private func contentView(for tab: Int) -> some View {
        switch tab {
        case 0:
            ChatBotSelectView()
        case 1:
            RandomStoryView()
        case 2:
            RecordView()
        default:
            EmptyView()
        }
    }

    func tabItem(icon: String, index: Int, label: String) -> some View {
        VStack {
            Image(icon)
            Text(label)
                .font(.system(size: 10))
        }
        .foregroundColor(selectedTab == index ? .white : .gray)
        .onTapGesture {
            selectedTab = index
        }
    }
}

#Preview {
    TabbarView()
}
