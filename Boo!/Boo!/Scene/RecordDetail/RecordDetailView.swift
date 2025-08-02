import SwiftUI

struct RecordDetailView: View {
    let reportId: String
    @StateObject private var viewModel = RecordViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            BackgroundWrapper {
                if let detail = viewModel.reportDetail {
                    VStack(spacing: 0) {
                        headerView
                        Spacer()
                        resultCard(detail: detail)
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 20)
                } else {
                    ProgressView()
                        .onAppear {
                            viewModel.getReportDetail(reportId: reportId) { _ in }
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
        .padding(.vertical, 10)
    }

    func resultCard(detail: ReportDetail) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(detail.title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    Text("\(detail.fearLevel)등급")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.orange)
                }

                Text("챗봇의 말")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                VStack(alignment: .leading, spacing: 12) {
                    Text(detail.summary)
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.9))
                        .lineSpacing(4)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)

            Spacer()

            bottomButton
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.sodomy3)
        )
    }

    var bottomButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("채팅 돌아가기")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 28)
                        .fill(.blue)
                )
        }
        .padding(20)
    }
}
