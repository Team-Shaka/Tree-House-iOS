//
//  DynamicHeightTextEditorView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/20/24.
//

import SwiftUI

struct DynamicHeightTextEditorView: View {
    @Binding var text: String
    @State private var textViewHeight: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Text 뷰를 이용해 텍스트의 높이 계산
            Text(text)
                .font(.fontGuide(.body3))
                .lineLimit(nil)
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4))
                .background(GeometryReader { geometry in
                    Color.clear.preference(key: ViewHeightKey.self, value: geometry.size.height)
                })
            
            // TextEditor 뷰
            TextEditor(text: $text)
                .font(.fontGuide(.body3))
                .frame(height: textViewHeight)
                .background(Color.clear)
        }
        .onPreferenceChange(ViewHeightKey.self) { height in
            textViewHeight = height
        }
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
