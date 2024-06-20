//
//  ImageDetailCarouselView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/15/24.
//

import SwiftUI

struct ImageDetailCarouselView: View {
    
    // MARK: - State Property
    
    @State private var selectedIndex: Int
    
    // MARK: - Property
    
    let images: [String]
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Initialize
    
    init(images: [String], selectedIndex: Int) {
        self.images = images
        self._selectedIndex = State(initialValue: selectedIndex)
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .frame(width: 393, height: 393)
                    }
                }
            }
            .background(.grayscaleBlack)
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .gesture(
                DragGesture()
                    .onEnded { value in
                        if value.translation.height > 100 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.grayscaleWhite)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("\(selectedIndex + 1)/\(images.count)")
                        .font(.fontGuide(.body2))
                        .foregroundStyle(.grayscaleWhite)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    ImageDetailCarouselView(images: [], selectedIndex: 1)
}
