//
//  ImageDetailCarouselView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/15/24.
//

import SwiftUI

struct ImageDetailCarouselView: View {
    
    // MARK: - State Property
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedIndex: Int
    
    let imageUrls: [String]
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.grayscaleWhite)
                }
                .padding(.leading, 14)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(selectedIndex + 1) / \(imageUrls.count)")
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(.grayscaleWhite)
                    .frame(maxWidth: .infinity)
            }
            
            TabView(selection: $selectedIndex) {
                ForEach(0..<imageUrls.count, id: \.self) { imageIndex in
                    CustomAsyncImage(url: imageUrls[imageIndex],
                                     type: .carouselImage)
                    .padding(.horizontal, 5)
                    .padding(.bottom, 30)
                    .tag(imageIndex)
                }
            }
        }
        .background(.grayscaleBlack)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
    }
}

// MARK: - Preview

#Preview {
    ImageDetailCarouselView(selectedIndex: .constant(0), imageUrls:[""])
}
