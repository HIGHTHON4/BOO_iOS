import SwiftUI

struct StoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let reportId: String
    
    @StateObject private var viewModel = TodayHorrorViewModel()
    @State private var detail: HorrorDetail?
    
    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 0) {
                    headerView
                    
                    if let detail = detail {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(detail.title)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 30)
                                    .padding(.bottom, 20)
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    ForEach(detail.text.split(separator: "\n").map(String.init), id: \.self) { paragraph in
                                        Text(paragraph)
                                            .font(.system(size: 16))
                                            .foregroundColor(.white.opacity(0.9))
                                            .lineSpacing(4)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.bottom, 30)
                                
                                VStack(spacing: 15) {
                                    Text("챗봇의 말")
                                        .font(.pretendard(.bold, size: 17))
                                        .foregroundColor(.white)
                                    Text(detail.content)
                                        .font(.pretendard(.light, size: 14))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    } else {
                        ProgressView()
                            .onAppear {
                                viewModel.fetchHorrorDetail(reportId: reportId) { result in
                                    self.detail = result
                                }
                            }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
    }
    
    var headerView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}
