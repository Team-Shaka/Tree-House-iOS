//
//  WebViewContainer.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/26/24.
//

import SwiftUI

struct WebViewContainer: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = true
    let url: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                WebView(url: url, isLoading: $isLoading)
                
                if isLoading {
                    LottieView(lottieFile: "treehouse_loading", speed: 1)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.treeBlack)
                    }
                    .padding(.top, 5)
                }
            }
        }
    }
}

#Preview {
    WebViewContainer(url: "")
}
