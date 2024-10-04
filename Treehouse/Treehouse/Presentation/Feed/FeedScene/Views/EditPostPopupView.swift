//
//  EditPostPopupView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/14/24.
//

import SwiftUI

struct EditPostPopupView: View {
    
    // MARK: - State Property
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (SheetActionViewModel.self) var sheetActionViewModel
    
    @State var updateFeedPostViewModel = UpdateFeedPostViewModel(updateFeedPostUseCase: UpdateFeedPostUseCase(repository: FeedRepositoryImpl()))
    
    @State private var isCancelPopupShowing: Bool = false
    @State var postContent: String
    @FocusState private var isFocused: Bool
    
    // MARK: - Property
    
    let postId: Int
    let memberProfile: MemberProfileEntity
    let postImageURLs: [String]

    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                editPostPopupHeaderView
                
                ScrollView {
                    HStack(alignment: .top, spacing: 10) {
                        
                        CustomAsyncImage(url: memberProfile.memberProfileImageUrl ?? "",
                                         type: .postMemberProfileImage,
                                         width: 36,
                                         height: 36)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(memberProfile.memberName)
                                .fontWithLineHeight(fontLevel: .body2)
                                .foregroundStyle(.treeBlack)
                                .padding(.bottom, 2)

                            TextEditor(text: $postContent)
                                .fontWithLineHeight(fontLevel: .body3)
                                .scrollContentBackground(.hidden)
                                .background(.grayscaleWhite)
                                .focused($isFocused)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.isFocused = true
                                    }
                                }
                                .padding(.bottom, 15)
                            
                            if postImageURLs.count == 1 {
                                CustomAsyncImage(url: postImageURLs.first ?? "",
                                                 type: .postImage,
                                                 width: 314,
                                                 height: 200)
                                .opacity(0.5)
                            } else {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(0..<postImageURLs.count, id: \.self) { index in
                                            CustomAsyncImage(url: postImageURLs[index], type: .postImage,
                                                             width: 206,
                                                             height: 200)
                                            .opacity(0.5)
                                        }
                                    }
                                    .padding(.leading, 62)
                                    .padding(.trailing, 16)
                                }
                            }
                            
                        }
                    }
                    .padding(16)
                }
            }
        }
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
        .topLevelAlert(isPresented: $isCancelPopupShowing) {
            cancleEditPopupView
        }
    }
}

extension EditPostPopupView {
    @ViewBuilder
    var editPostPopupHeaderView: some View {
        HStack(alignment: .center) {
            Button(action: {
                hideKeyboard()
                self.isCancelPopupShowing.toggle()
            }) {
                Text("취소")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray7)
            }
            .frame(width: 44, height: 32)
            .padding(.leading, 16)
            
            Spacer()
            
            Text("게시글 수정")
                .fontWithLineHeight(fontLevel: .body2)
                .foregroundStyle(.grayscaleBlack)
            
            Spacer()
            
            Button(action: {
                hideKeyboard()
                Task {
                    await updateFeedPostViewModel.updateFeedPost(treehouseId: feedViewModel.currentTreehouseId ?? 0, postId: postId, context: postContent)
                    
                    if updateFeedPostViewModel.isUpdatePost {
                        sheetActionViewModel.isEditPostPopupShowing.toggle()
                        feedViewModel.modifyPostContent = (postId, postContent)
                    }
                }
            }) {
                Text("완료")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.grayscaleWhite)
            }
            .frame(width: 49, height: 32)
            .background(.treeGreen)
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            .padding(.trailing, 16)
        }
        .padding(.top, 18)
    }
    
    @ViewBuilder
    var cancleEditPopupView: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            Spacer()
            
            PostAlertView(
                alertContent: "수정한 내용을 삭제하시겠어요?",
                onCancel: {
                    isCancelPopupShowing .toggle()
                },
                onConfirm: {
                    isCancelPopupShowing.toggle()
                    sheetActionViewModel.isEditPostPopupShowing.toggle()
                }
            )
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            )
            
            Spacer()
        }
    }
}

// MARK: - Preview

//#Preview {
//    EditPostPopupView()
//}
