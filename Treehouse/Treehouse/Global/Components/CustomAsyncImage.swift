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
}

struct CustomAsyncImage: View {
    
    var url: String
    var type: ImageType
    var width: CGFloat
    var height: CGFloat
    var onImageLoaded: ((Image) -> Void)?
    
    init(url: String, type: ImageType, width: CGFloat, height: CGFloat) {
        self.url = url
        self.type = type
        self.width = width
        self.height = height
    }
    
    init(url: String, type: ImageType, width: CGFloat, height: CGFloat, onImageLoaded: @escaping (Image) -> Void) {
        self.init(url: url, type: type, width: width, height: height)
        if type == .postImage {
            self.onImageLoaded = onImageLoaded
        }
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onAppear {
                        print("Image 로드 됨")
                        if type == .postImage {
                            onImageLoaded?(image)
                        }
                    }
                   
            case .failure(_):
                Image(systemName: "exclamationmark.icloud.fill")
                    .resizable()
                    .scaledToFit()
                
            case .empty:
                if URL(string: url) == nil || url.isEmpty {
                    switch type {
                    case .memberProfileImage:
                        Image(.imgUser)
                            .resizable()
                            .scaledToFit()
                    case .postMemberProfileImage:
                        Image(.imgProfile)
                            .resizable()
                            .scaledToFit()
                    case .postImage:
                        Image(.imgDummy)
                            .resizable()
                            .scaledToFit()
                    case .treehouseImage:
                        Image(.imgGroup)
                            .resizable()
                            .scaledToFit()
                    case .postTreehouseImage:
                        Image(.imgGroup)
                            .resizable()
                            .scaledToFit()
                    }
                }
            @unknown default:
                ProgressView()
            }
        }
        .frame(width: SizeLiterals.Screen.screenWidth * width / 393, height: SizeLiterals.Screen.screenHeight * height / 852)
        .cornerRadius(6.0)
    }
}

//#Preview {
//    CustomAsyncImage(url: "", type: .treehouseImage, width: 36, height: 36)
//}
