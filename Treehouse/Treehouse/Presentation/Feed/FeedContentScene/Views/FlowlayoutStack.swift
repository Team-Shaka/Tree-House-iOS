//
//  FlowlayoutStack.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/24/24.
//

import SwiftUI

public struct FlowlayoutStack<Content: View>: View {
    
    // MARK: - Property
    
    let content: () -> Content
    let spacing: CGSize

    public init(verticalSpacing: CGFloat = .zero, horizontalSpacing: CGFloat = .zero, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.spacing = CGSize(width: verticalSpacing, height: horizontalSpacing)
    }
    
    // MARK: - View

    public var body: some View {
        ZStack(alignment: .topLeading) {
            // Setup for layout pass
            var availableWidth: CGFloat = 0
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            Color.green
                .frame(height: 0)
                .alignmentGuide(.top) { item in
                    availableWidth = item.width // 사용할 수 있는 width
                    x = 0
                    y = 0
                    return 0
                }

            content()
                .alignmentGuide(.leading) { item in
                    // width 보다 행의 길이가 더 길어진다면
                    if x + item.width > availableWidth {
                        x = 0 // x 의 시작점을 0 으로
                        y += item.height + spacing.height // y 를 요소의 높이와 행간의 높이 만큼으로 잡아 2번째 열부터 시작
                    }
                    let startX = x
                    x += item.width + spacing.width // 요소를 추가하고 다음 시작할 x 좌표
                    return -startX // alignment 기준으로 왼쪽으로 이동 (양수), 오른쪽으로 이동 (음수)
                }
                .alignmentGuide(.top) { _ in
                    return -y // alignment 기준으로 위로 이동 (양수), 아래로 이동 (음수)
                }
        }
    }
}
