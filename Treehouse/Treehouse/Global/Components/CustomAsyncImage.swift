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
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                   
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
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            
            @unknown default:
                ProgressView()
            }
        }.frame(width: width, height: height)
        .cornerRadius(6.0)
    }
}

#Preview {
    CustomAsyncImage(url: "", type: .treehouseImage, width: 36, height: 36)
}
