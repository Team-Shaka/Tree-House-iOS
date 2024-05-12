//
//  SinglePostView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import SwiftUI

struct SinglePostView: View {
    
    // MARK: - Property
    
    let userProfileImageURL: String
    let sentTime: Int
    let postContent: String
    let postImageURLs: [String]
    
    // MARK:  - State Property
    
    @State private var isBottomSheetShowing = false
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray3)
            
            HStack(alignment: .top, spacing: 10) {
                Image(.imgDummy2)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 36, height: 36)
                
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 9) {
                        Text("username")
                            .font(.fontGuide(.body2))
                            .foregroundStyle(.treeBlack)
                            .fontWithLineHeight(fontLevel: .body2)
                        
                        Text("branch 3분 전")
                            .font(.fontGuide(.caption1))
                            .foregroundStyle(.gray5)
                            .fontWithLineHeight(fontLevel: .caption1)
                        
                        Spacer()
                        
                        Button(action: {
                            print("meatball button tapped")
                            // TODO: - Bottom Sheet 연결
                            self.isBottomSheetShowing.toggle()
                        }) {
                            Image(.icMeatball)
                        }
                    }
                    
                    Text("contentcontent~")
                        .font(.fontGuide(.body3))
                        .foregroundStyle(.treeBlack)
                    
                    multipleImagesView
                    
                    commentCountView
                }
            }
            .padding(16)
        }
    }
}

// MARK: - ViewBuilder

extension SinglePostView {
    @ViewBuilder
    var contentImageView: some View {
        if postImageURLs.count == 1 {
            singleImageView
        } else {
            multipleImagesView
        }
    }
    
    @ViewBuilder
    var commentCountView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: 315, height: 40)
                .foregroundColor(.gray1)
            
            HStack(spacing: 5) {
                Image(.icGreenReply)
                
                Text("nn comments")
                    .font(.fontGuide(.body4))
                    .foregroundStyle(.gray7)
            }
            .padding(.trailing, 180)
        }
    }
    
    @ViewBuilder
    var singleImageView: some View {
        Image(.imgDummy)
            .resizable()
            .frame(width: 315, height: 172)
            .cornerRadius(6.0)
    }
    
    @ViewBuilder
    var multipleImagesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Image(.imgDummy)
                    .resizable()
                    .cornerRadius(6.0)
                    .frame(width: 206, height: 172)
                
                Image(.imgDummy2)
                    .resizable()
                    .cornerRadius(6.0)
                    .frame(width: 206, height: 172)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SinglePostView(userProfileImageURL: "",
                   sentTime: 5,
                   postContent: "",
                   postImageURLs: ["", ""])
}
    
