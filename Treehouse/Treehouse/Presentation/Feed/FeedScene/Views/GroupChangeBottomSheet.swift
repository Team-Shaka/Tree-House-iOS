//
//  GroupChangeBottomSheet.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/25/24.
//

import SwiftUI

public struct GroupChangeBottomSheet<Content>: View where Content: View {
    
    // MARK: - Property
    
    public var height: CGFloat
    public var content: Content
    
    // MARK: - Binding Property
    
    @Binding public var isPresented: Bool
    
    // MARK: - GestureState Property

    @GestureState private var translation: CGFloat = .zero

    public init(_ isPresented: Binding<Bool>, height: CGFloat, content: () -> Content) {
        self._isPresented = isPresented
        self.height = height
        self.content = content()
    }
    
    // MARK: - View

    public var body: some View {
        VStack(spacing: .zero) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.gray4)
                        .frame(width: SizeLiterals.Screen.screenWidth * 50/393, height: 4)
                )

            self.content
                .frame(height: self.height)
        }
        .frame(height: self.height+30)
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(20, corners: .topLeft)
                .cornerRadius(20, corners: .topRight)
                .edgesIgnoringSafeArea([.bottom, .horizontal])
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .offset(y: translation)
        .gesture(
            DragGesture()
                .updating($translation) { value, state, _ in
                    if 0 <= value.translation.height {
                        let translation = min(self.height, max(-self.height, value.translation.height))
                        state = translation
                    }
                }
                .onEnded({ value in
                    if value.translation.height >= height / 3 {
                        self.isPresented = false
                    }
                })
        )
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
