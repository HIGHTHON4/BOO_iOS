import SwiftUI

struct ChatBotIntroduction: View {
    var icon: String
    var name: String
    var content: String
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.sodomy1)
                .frame(height: 100)
            RoundedRectangle(cornerRadius: 16)
                .fill(.sodomy2)
                .frame(width: 80, height: 80)
                .padding(.leading, 10)
            Image(icon)
                .padding(.leading, 20)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.pretendard(.bold, size: 16))
                    .foregroundStyle(.whiteBoo)
                Spacer()
                Text(content)
                    .font(.pretendard(.light, size: 12))
                    .foregroundStyle(.whiteBoo)
            }
            .padding(.leading, 117)
            .padding(.trailing, 20)
            .frame(height: 80)
        }
        .background(.clear)
    }
}

#Preview {
    ZStack {
        Color.black
        ChatBotIntroduction(icon: "boo", name: "꼬마 유령 Boo!", content: "말수가 적고 따뜻한 공감러 \n감정의 결을 놓치지 않고, 한 얘기에 길게 집중해줌 조용히, 천천히 얘기할 때 추천")
    }
}
