//
//  CustomBottomSheet.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/12/24.
//

import SwiftUI

struct CustomBottomSheet<Content: View>: View {
    
    // MARK: - Property
    
    let content: () -> Content
    
    // MARK: - State Property
    
    @Binding var isPresented: Bool
    
    @State private var offsetY: CGFloat = 0
    @State private var backgroundOpacity: CGFloat = 0
    @State var topPadding: CGFloat = 0
    
    // MARK: - View
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isPresented {
                    Color.black.opacity(backgroundOpacity)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isPresented = false
                            }
                        }
                        .onAppear {
                            print("backgroundOpacity", backgroundOpacity)
                            withAnimation {
                                backgroundOpacity = 0.3
                            }
                        }
                    
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 2.5)
                            .foregroundStyle(.gray4)
                            .frame(width: 50, height: 4)
                            .padding(.top, 10)
                            .padding(.bottom, 18)
                        
                        content()
                    }
                    .padding(EdgeInsets(top: 0, leading: 17, bottom: 10, trailing: 16))
                    .background(.gray2)
                    .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
                    .transition(AnyTransition.move(edge: .bottom))
                    .padding(.top, topPadding)
                    .offset(y: max(self.offsetY, 0))
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                print(value.translation.height)
                                self.offsetY = value.translation.height
                            }
                            .onEnded { value in
                                if self.offsetY > geometry.size.height / 4 {
                                    withAnimation {
                                        self.isPresented = false
                                        backgroundOpacity = 0.0
                                    }
                                } else {
                                    withAnimation {
                                        self.offsetY = 0
                                    }
                                }
                            }
                    )
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isPresented)
            .ignoresSafeArea(edges: .bottom)
        }.onChange(of: isPresented) { _, newValue in
            if newValue {
                self.offsetY = 0 // 다시 열릴 때 항상 같은 위치에 있도록 offset 초기화
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CustomBottomSheet<EmojiGridView>(content: {
        EmojiGridView(viewModel: FeedContentViewModel())
    }, isPresented: .constant(true))
}
