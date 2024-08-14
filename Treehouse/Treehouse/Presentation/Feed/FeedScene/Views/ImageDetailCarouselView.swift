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
    @State var selectedIndex: Int
    @Binding var images: [(Int,UIImage)]
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                ForEach(0..<images.count, id: \.self) { imageIndex in
                    Image(uiImage: images[imageIndex].1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 5)
                        .frame(maxWidth:.infinity)
                        .padding(.bottom, 30)
                        .tag(imageIndex)
                }
            }
            .background(.grayscaleBlack)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .onAppear {
                images = images.sorted(by: {$0.0 < $1.0} )
            }
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
                    Text("\(selectedIndex + 1) / \(images.count)")
                        .fontWithLineHeight(fontLevel: .body2)
                        .foregroundStyle(.grayscaleWhite)
                }
            }
        }
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

//#Preview {
//    ImageDetailCarouselView(images: [], selectedIndex: 1)
//}
