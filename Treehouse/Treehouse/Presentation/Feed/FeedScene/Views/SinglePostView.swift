//
//  SinglePostView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import SwiftUI
import PopupView

struct SelectedImage: Identifiable {
    var id: Int
}

enum PostType {
    case feedView
    case DetailView
}

struct SinglePostView: View {
    
    // MARK: - State Property
    
    @Environment (ViewRouter.self) var viewRouter
    @Environment (FeedViewModel.self) var feedViewModel
    
    // MARK: - Property
    
    let postId: Int?
    let sentTime: String
    var postContent: String
    let postImageURLs: [String]
    let memberProfile: MemberProfileEntity
    var postType: PostType
    
    // MARK:  - State Property
    
    @State private var selectedImage: SelectedImage? = nil
    @State private var viewModel = SheetActionViewModel()
    
    init(postId: Int?, sentTime: String, postContent: String, postImageURLs: [String], memberProfile: MemberProfileEntity, postType: PostType) {
        self.postId = postId
        self.sentTime = sentTime
        self.postContent = postContent
        self.postImageURLs = postImageURLs
        self.memberProfile = memberProfile
        self.postType = postType
    }
    
    init(sentTime: String, postContent: String, postImageURLs: [String], memberProfile: MemberProfileEntity, postType: PostType) {
        self.postId = nil
        self.sentTime = sentTime
        self.postContent = postContent
        self.postImageURLs = postImageURLs
        self.memberProfile = memberProfile
        self.postType = postType
    }
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(.gray3)
                
                HStack(alignment: .top, spacing: 10) {
                    CustomAsyncImage(url: memberProfile.memberProfileImageUrl ?? "", 
                                     type: .postMemberProfileImage,
                                     width: 36,
                                     height: 36)
                        .clipShape(Circle())
                        .onTapGesture {
                            viewRouter.push(ProfileRouter.memberProfileView(treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                                                            memberId: memberProfile.memberId))
                        }
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .center, spacing: 9) {
                            Text(memberProfile.memberName)
                                .fontWithLineHeight(fontLevel: .body2)
                                .foregroundStyle(.treeBlack)
                                .onTapGesture {
                                    viewRouter.push(ProfileRouter.memberProfileView(treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                                                                    memberId: memberProfile.memberId))
                                }
                            
                            Text(sentTime)
                                .fontWithLineHeight(fontLevel: .caption1)
                                .foregroundStyle(.gray5)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.isBottomSheetShowing.toggle()
                            }) {
                                Image(.icMeatball)
                                    .frame(width: 32, height: 32)
                            }
                        }
                        
                        Text(postContent)
                            .fontWithLineHeight(fontLevel: .body3)
                            .foregroundStyle(.treeBlack)
                    }
                }
                .padding(16)
                .zIndex(1)
                
                contentImageView()
            }
            .fullScreenCover(item: $selectedImage) { selectedImage in
                ImageDetailCarouselView(images: postImageURLs, selectedIndex: selectedImage.id)
            }
        }
        // 바텀시트 표출
        .popup(isPresented: $viewModel.isBottomSheetShowing) {
            FeedBottomSheetRowView(sheetCase: viewModel.sheetCase) { action in
                viewModel.handleSheetAction(action)
            }
        } customize: {
            $0
                .type(.toast)
                .closeOnTapOutside(true)
                .dragToDismiss(true)
                .isOpaque(true)
                .backgroundColor(.treeBlack.opacity(0.5))
        }
        // 게시글 수정 바텀시트 표출
        .popup(isPresented: $viewModel.isEditPostPopupShowing) {
            EditPostPopupView(postContent: postContent, postId: postId ?? 0, memberProfile: memberProfile, postImageURLs: postImageURLs)
                .background(.grayscaleWhite)
                .frame(height: SizeLiterals.Screen.screenHeight * 790 / 852)
                .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
                .environment(viewModel)
        } customize: {
            $0
                .type(.toast)
                .dragToDismiss(true)
                .isOpaque(true)
                .closeOnTap(false)
                .backgroundColor(.treeBlack.opacity(0.5))
        }
    }
}

// MARK: - ViewBuilder

extension SinglePostView {
    @ViewBuilder
    func contentImageView() -> some View {
        if postImageURLs.count == 1 {
            singleImageView
        } else {
            multipleImagesView
        }
    }
    
    @ViewBuilder
    var singleImageView: some View {
        CustomAsyncImage(url: postImageURLs.first ?? "", 
                         type: .postImage,
                         width: 314,
                         height: 200)
            .onTapGesture {
                if postType == .DetailView {
                    selectedImage = SelectedImage(id: 0)
                } else {
                    feedViewModel.currentPostId = postId
                    viewRouter.push(FeedRouter.postDetailView)
                }
            }
            .padding(.leading, 62)
            .padding(.trailing, 16)
    }
    
    @ViewBuilder
    var multipleImagesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<postImageURLs.count, id: \.self) { index in
                    CustomAsyncImage(url: postImageURLs[index], type: .postImage,
                                     width: 206,
                                     height: 200)
                        .onTapGesture {
                            if postType == .DetailView {
                                selectedImage = SelectedImage(id: index)
                            } else {
                                feedViewModel.currentPostId = postId
                                viewRouter.push(FeedRouter.postDetailView)
                            }
                        }
                }
            }
            .padding(.leading, 62)
            .padding(.trailing, 16)
        }
    }
}

// MARK: - Preview

//#Preview {
//    SinglePostView(userProfileImageURL: "",
//                   sentTime: "5",
//                   postContent: "",
//                   postImageURLs: ["", ""],
//                   postType: .feedView)
//        .environment(ViewRouter())
//}
