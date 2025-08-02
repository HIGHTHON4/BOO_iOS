import SwiftUI

enum PretendardFont: String {
    case bold = "Pretendard-Bold"
    case light = "Pretendard-Light"
    case medium = "Pretendard-Medium"
    case semibold = "Pretendard-Semibold"
}

extension Font {
    static func pretendard(_ style: PretendardFont, size: CGFloat) -> Font {
        return .custom(style.rawValue, size: size)
    }
}
