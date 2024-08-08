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
    var radius: CGFloat
    var corners: UIRectCorner
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = max(radius, 0) // 음수 값 방지
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        guard !rect.isEmpty else {
            return Path()
        }
        
        // Ensure radius is valid and non-zero
        let validRadius = radius.isNaN ? 0 : radius
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: validRadius, height: validRadius))
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
    
    /// 입력 조건(글자수) 설정하는 메서드
    func isLengthValid(_ input: String) -> Bool {
        return input.count >= 4 && input.count <= 20
    }
    
    /// 원하는 모서리에 라운드 처리해주는 메서드
    func selectCornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// 인정번호 개수에 따른 버튼 활성화 & UI 를 처리하는 메서드
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .foregroundStyle(condition ? Color.gray6 : Color.gray1)
            .background(condition ? Color.gray2 : Color.treeBlack)
    }
    
    /// Bottom Sheet 를 보여주는 메서드
    func bottomSheet<Content>(isPresented: Binding<Bool>, topPadding: CGFloat, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        ZStack {
            self
            CustomBottomSheet(content: content, isPresented: isPresented, topPadding: topPadding)
        }
    }
}

extension View {
    func customAlert(alertType: AlertType,
                              isPresented: Binding<Bool>,
                              onCancel: @escaping () -> Void,
                              onConfirm: @escaping () -> Void) -> some View {
        self
            .fullScreenCover(isPresented: isPresented) {
                CustomAlertView(
                    alertType: alertType,
                    onCancel: {
                        onCancel()
                        isPresented.wrappedValue = false
                    },
                    onConfirm: {
                        onConfirm()
                        isPresented.wrappedValue = false
                    }
                )
                .presentationBackground {
                    Color.alertBackground
                        .background(.ultraThinMaterial)
                }
            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}
