//
//  CustomAsyncImage.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/25/24.
//

import SwiftUI

enum ImageType {
    case treehouseImage
    case postTreehouseImage
    case postMemberProfileImage
    case memberProfileImage
    case postImage
    case notiProfileImage
}

struct CustomAsyncImage: View {
    @State var imageLoader: ImageLoader
    
    var url: String
    var type: ImageType
    var width: CGFloat
    var height: CGFloat
    var onImageLoaded: ((UIImage) -> Void)?
    
    init(url: String, type: ImageType, width: CGFloat, height: CGFloat) {
        self.url = url
        self.type = type
        self.width = width
        self.height = height
        self._imageLoader = State(wrappedValue: ImageLoader(url: url))
    }
    
    init(url: String, type: ImageType, width: CGFloat, height: CGFloat, onImageLoaded: @escaping (UIImage) -> Void) {
        self.init(url: url, type: type, width: width, height: height)
        if type == .postImage {
            self.onImageLoaded = onImageLoaded
        }
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            switch imageLoader.state {
            case .loading:
                ProgressView()
                    
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        if type == .postImage {
                            onImageLoaded?(image)
                        }
                    }
            case .failure:
                failurebackImage
            }
        }
        .frame(width: SizeLiterals.Screen.screenWidth * width / 393, height: SizeLiterals.Screen.screenHeight * height / 852)
        .cornerRadius(6.0)
        .onAppear {
            Task {
                await imageLoader.fetch()
            }
        }
    }
    
    @ViewBuilder
    private var failurebackImage: some View {
        switch type {
        case .memberProfileImage:
            Image(.imgUser)
                .resizable()
                .scaledToFit()
        case .postMemberProfileImage, .notiProfileImage:
            Image(.imgProfile)
                .resizable()
                .scaledToFit()
        case .postImage:
            Image(.imgDummy)
                .resizable()
                .scaledToFit()
        case .treehouseImage, .postTreehouseImage:
            Image(.imgGroup)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    CustomAsyncImage(url: "", type: .treehouseImage, width: 36, height: 36)
}
