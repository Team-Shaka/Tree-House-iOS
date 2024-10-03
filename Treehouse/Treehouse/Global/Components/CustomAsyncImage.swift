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
    case carouselImage
}

struct CustomAsyncImage: View {
    
    @State private var loadState: LoadState = .loading
    
    let url: String
    var type: ImageType
    var width: CGFloat
    var height: CGFloat
    
    /// ImageDetailCarouselView 이외에서 사용하는 init
    init(url: String, type: ImageType, width: CGFloat, height: CGFloat) {
        self.url = url
        self.type = type
        self.width = width
        self.height = height
    }
    
    /// ImageDetailCarouselView 에서 사용하는 init
    init(url: String, type: ImageType) {
        self.url = url
        self.type = type
        self.width = SizeLiterals.Screen.screenWidth
        self.height = SizeLiterals.Screen.screenHeight
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            switch loadState {
            case .loading:
                loadingView
                    .frame(width: SizeLiterals.Screen.screenWidth * width / 393, height: SizeLiterals.Screen.screenHeight * height / 852)
                
            case .success(let data):
                switch type {
                case .carouselImage:
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth:.infinity)
                    
                default:
                    Image(uiImage: UIImage(data: data) ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: SizeLiterals.Screen.screenWidth * width / 393, height: SizeLiterals.Screen.screenHeight * height / 852)
                        .cornerRadius(6.0)
                        .contentShape(Rectangle())
                }
                   
            case .failure:
                failurebackImage
                    .frame(width: SizeLiterals.Screen.screenWidth * width / 393, height: SizeLiterals.Screen.screenHeight * height / 852)
            }
        }
        .task {
            loadState = await ImageLoader.shared.loadImage(url: url)
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        switch type {
        case .memberProfileImage, .postMemberProfileImage:
            Circle()
                .fill(.gray3)
        case .postImage:
            RoundedRectangle(cornerRadius: 6.0)
                .fill(.gray3)
        default:
            ProgressView()
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
        case .postImage, .carouselImage:
            RoundedRectangle(cornerRadius: 6.0)
                .fill(.gray3)

        case .treehouseImage, .postTreehouseImage:
            Image(.imgGroup)
                .resizable()
                .scaledToFit()
        }
    }
}


#Preview {
    CustomAsyncImage(url: "",
                     type: .treehouseImage,
                     width: 36,
                     height: 36)
}
