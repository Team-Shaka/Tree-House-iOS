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

extension View {
    func fontWithLineHeight(fontLevel: FontLevel) -> some View {
        return ModifiedContent(content: self, 
                               modifier: FontWithLineHeight(font: Font.uiFontGuide(fontLevel), lineHeight: fontLevel.lineHeight))
    }
    
    func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // 상단 SafeArea 의 높이를 반환해주는 메서드
    func safeAreaHeight() -> CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
            return statusBarHeight
        }
        return 0
    }
}
