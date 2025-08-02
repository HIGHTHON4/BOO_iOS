import SwiftUI

struct TabbarView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                contentView(for: selectedTab)
                Spacer(minLength: 0)
                customTabbar
            }
        }
        .background(.gradit2)
    }

    private var customTabbar: some View {
        HStack(spacing: 60) {
            tabItem(icon: selectedTab == 0 ? "chatBotSelected" : "chatBot", index: 0, label: "챗봇")
            tabItem(icon: selectedTab == 1 ? "earthSelected" : "earth", index: 1, label: "랜덤 괴담")
            tabItem(icon: selectedTab == 2 ? "recordSelected" : "record", index: 2, label: "챗봇 기록")
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

    @ViewBuilder
    private func contentView(for tab: Int) -> some View {
        switch tab {
        case 0: ChatBotView()
        case 1: RandomStoryView()
        case 2: RecordView()
        default: EmptyView()
        }
    }
}

#Preview {
    TabbarView()
}
