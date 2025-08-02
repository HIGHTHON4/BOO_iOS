import SwiftUI

struct RecordView: View {
    @State private var selectedCategory = "최신순"
    @State private var selectedAIs: Set<String> = ["전체"]
    @StateObject private var viewModel = RecordViewModel()
    
    let categories = ["최신순", "등급순", "날짜"]
    let aiOptions = ["전체", "Boo!", "강무진", "엘리", "쏘쏘"]
    
    private let aiUUIDMap: [String: String] = [
        "Boo!": "04d94214-6fce-11f0-9f6c-f645757d12e0",
        "강무진": "1b9c5e3d-0136-4e5c-80e3-85711e1f53f8",
        "엘리": "8fca0a47-5d8f-4d4f-a9a7-352382d23ff3",
        "쏘쏘": "c17bba2f-e16c-4c80-9b90-6fc1841452d1"
    ]
    
    var body: some View {
        NavigationView {
            BackgroundWrapper {
                VStack(spacing: 0) {
                    headerView
                    filterButtonsView
                    recordingsList
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden()
        .onAppear {
            callAPI()
        }
    }
    
    var headerView: some View {
        HStack {
            Text("괴담 리프트 목록")
                .font(.pretendard(.bold, size: 20))
                .foregroundStyle(.whiteBoo)
                .padding(.top, 30)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    
    var filterButtonsView: some View {
        HStack(spacing: 0) {
            VStack {
                Text("정렬")
                    .font(.pretendard(.light, size: 12))
                    .foregroundStyle(.whiteBoo)
                    .padding(.vertical, 18)
                Text("AI")
                    .font(.pretendard(.light, size: 12))
                    .foregroundStyle(.whiteBoo)
            }
            .padding(.leading, 20)
            .padding(.trailing, 10)
            
            VStack(spacing: 12) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                callAPI()
                            }) {
                                Text(category)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedCategory == category ? .white : .gray)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(selectedCategory == category ? Color.blue : Color.gray.opacity(0.3))
                                    )
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(aiOptions, id: \.self) { option in
                            Button(action: {
                                if option == "전체" {
                                    selectedAIs = ["전체"]
                                } else {
                                    if selectedAIs.contains(option) {
                                        selectedAIs.remove(option)
                                        if selectedAIs.isEmpty {
                                            selectedAIs = ["전체"]
                                        }
                                    } else {
                                        selectedAIs.remove("전체")
                                        selectedAIs.insert(option)
                                    }
                                }
                                callAPI()
                            }) {
                                Text(option)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedAIs.contains(option) ? .white : .gray)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(selectedAIs.contains(option) ? Color.blue : Color.gray.opacity(0.3))
                                    )
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    var recordingsList: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(Array(viewModel.reports.enumerated()), id: \.element.reportId) { index, report in
                    NavigationLink(destination: RecordDetailView(reportId: report.reportId)) {
                        RecordingRowView(
                            title: report.title,
                            date: report.date,
                            grade: report.level ?? "-",
                            backgroundColor: getRowColor(for: index)
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func callAPI() {
        let sortParam = convertCategoryToSortParam(selectedCategory)

        let aiParam: [String]
        if selectedAIs.contains("전체") || selectedAIs.contains("") {
            aiParam = Array(aiUUIDMap.values)
        } else {
            aiParam = selectedAIs.compactMap { aiUUIDMap[$0] }
        }

        viewModel.getMyReports(sort: sortParam, ai: aiParam)
    }
    
    private func convertCategoryToSortParam(_ category: String) -> String {
        switch category {
        case "최신순":
            return "TIME"
        case "등급순":
            return "LEVEL"
        default:
            return "LAST"
        }
    }
    
    func getRowColor(for index: Int) -> Color {
        let colors: [Color] = [
            Color(red: 0.2, green: 0.25, blue: 0.4),
            Color(red: 0.3, green: 0.2, blue: 0.25),
            Color(red: 0.2, green: 0.3, blue: 0.2),
            Color(red: 0.25, green: 0.2, blue: 0.3)
        ]
        return colors[index % colors.count]
    }
}

struct RecordingRowView: View {
    let title: String
    let date: String
    let grade: String
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                Text(date)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(grade)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
        )
    }
}
