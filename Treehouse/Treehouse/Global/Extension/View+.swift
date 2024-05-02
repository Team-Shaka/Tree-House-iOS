//
//  View+.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/8/24.
//

import SwiftUI

struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func fontWithLineHeight(fontLevel: FontLevel) -> some View {
        return ModifiedContent(content: self, 
                               modifier: FontWithLineHeight(font: Font.uiFontGuide(fontLevel), 
                                                            lineHeight: fontLevel.lineHeight))
    }
    
    /// 외부 탭 시, 키보드 내려주는 메서드
    func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    /// 상단 SafeArea 의 높이를 반환해주는 메서드
    func safeAreaHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
            return statusBarHeight
        }
        return 0
    }
    
    /// 입력 조건을 설정하는 메서드
    func isValidInputUserId(_ input: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[0-9a-z_\\.]{4,20}$")
        let range = NSRange(location: 0, length: input.utf16.count)
        return regex.firstMatch(in: input, options: [], range: range) != nil
    }
    
    /// 원하는 모서리에 라운드 처리해주는 메서드
    func selectCornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
