//
//  FeedView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import SwiftUI

enum FeedField {
    case post
}

enum FeedViewStateType {
    case empty
    case notEmpty
}

struct FeedView: View {
    
    // MARK: - State Property
    
    @Environment (ViewRouter.self) var viewRouter
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (PostViewModel.self) var postViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    
    @State var commentViewModel = CommentViewModel(createCommentUseCase: CreateCommentUseCase( repository: CommentRepositoryImpl()),readCommentUseCase: ReadCommentUseCase(repository: CommentRepositoryImpl()), createReplyCommentUseCase: CreateReplyCommentUseCase(repository: CommentRepositoryImpl()))
    
    @State var presingedURLViewModel = PresingedURLViewModel(presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()))
    @State var loadImageAWSViewModel = LoadImageAWSViewModel(uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()))
    
    @State private var postContent: String = ""
    @State private var textFieldState: TextFieldStateType = .notFocused
    @StateObject private var photoPickerManager = PhotoPickerManager(type: .postImage)
    @State private var isPickerPresented = false
    
    @FocusState private var focusedField: FeedField?
    @FocusState private var isKeyboardShowing: Bool
    
    // MARK: - View
    
    var body: some View {
        @Bindable var feedViewModel = feedViewModel
        VStack(spacing: 0) {
            postTextField
            
            if postViewModel.feedListData.isEmpty == false {
                feedRowView
            } else {
                emptyFeedView
            }
        }
        .popup(isPresented: $feedViewModel.isSelectEmojiView) {
            if let postId = feedViewModel.currentPostId {
                EmojiGridView(emojiType: .feedView, postId: postId)
                    .environment(feedViewModel)
                    .environment(emojiViewModel)
            }
        } customize: {
            $0
                .type(.toast)
                .closeOnTapOutside(true)
                .dragToDismiss(true)
                .isOpaque(true)
                .backgroundColor(.treeBlack.opacity(0.5))
        }
        .onChange(of: feedViewModel.isSelectEmojiView) { _, newValue in
            if newValue == false {
                Task {
                    _ = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
                }
            }
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .post {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
        .onChange(of: photoPickerManager.selectedImages) { _, newValue in
            postViewModel.selectImage = newValue
        }
        .onChange(of: feedViewModel.modifyPostContent.1) { _, newValue in
            if newValue.isEmpty == false {
                let result = postViewModel.changePostContent(postId: feedViewModel.modifyPostContent.0, content: newValue)
                if result {
                    feedViewModel.modifyPostContent.1 = ""
                }
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            photoPickerManager.presentPhotoPicker()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - View Builder

extension FeedView {
    @ViewBuilder
    private var postTextField: some View {
        VStack(spacing: 0) {
            HStack() {
                TextField("\(feedViewModel.treehouseName)에 글쓰기...", text: $postContent, axis: .vertical)
                    .padding(EdgeInsets(top: 12.0, leading: 14.0, bottom: 12.0, trailing: 14.0))
                    .fontWithLineHeight(fontLevel: .body5)
                    .tint(.treeGreen)
                    .foregroundColor(textFieldState.fontColor)
                    .focused($focusedField, equals: .post)
                    .focused($isKeyboardShowing)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .frame(width: 320)
                    .lineLimit(2)
                    .background(.gray2)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button(action: {
                                isPickerPresented = true
                            }){
                                Image(.icPhoto)
                            }
                            Button(action: {
                                isKeyboardShowing = false
                            }){
                                Image(.icDelete2)
                            }
                        }
                    }
                    .padding(.leading, 16)
                
                Button(action: {
                    Task {
                        let presingedResult = await presingedURLViewModel.presignedURL(
                            treehouseId: feedViewModel.currentTreehouseId ?? 0,
                            memberId: feedViewModel.userId,
                            selectImage: photoPickerManager.selectedImages
                        )
                        
                        if let result = presingedResult {
                            let loadResult = await loadImageAWSViewModel.loadImageAWS(uploadImages: photoPickerManager.selectedImages, ImageUrl: result)
                            
                            let createResult = await postViewModel.createFeedPost(treehouseId: feedViewModel.currentTreehouseId ?? 0, context: postContent, pictureUrlList: result)
                            
                            if loadResult && createResult {
                                photoPickerManager.selectedImages.removeAll()
                                postContent = ""
                                hideKeyboard()
                                
                                let _ = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)

                            }
                        } else {
                            print("Post 실패")
                        }
                    }
                }) {
                    Image(textFieldState == .enable ? .icReply : .icReplyUnable)
                }
                .padding(.trailing, 16)
            }
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            if !photoPickerManager.selectedImages.isEmpty {
                selectedPhotosView
            }
        }
    }
    
    @ViewBuilder
    var selectedPhotosView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(photoPickerManager.selectedImages, id: \.self) { image in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray3, lineWidth: 1))
                            .frame(width: 54, height: 54)
                        
                        Button(action: {
                            if let index = photoPickerManager.selectedImages.firstIndex(of: image) {
                                photoPickerManager.selectedImages.remove(at: index)
                            }
                        }){
                            Image(.btnImgdelete)
                        }
                        .offset(x: 10, y: -10)
                    }
                }
            }
            .padding(EdgeInsets(top: 11, leading: 16, bottom: 7, trailing: 16))
            
        }
    }
    
    @ViewBuilder
    func contentView(viewState: FeedViewStateType) -> some View {
        switch viewState {
        case .empty:
            emptyFeedView
        case .notEmpty:
            Text("dfdf")
        }
    }
    
    @ViewBuilder
    var emptyFeedView: some View {
        VStack(spacing: 20) {
            Image(.imgFeedempty)
            
            Text("아직 올라온 게시글이 없어요")
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.gray5)
        }
        .frame(height: 482)
    }
    
    @ViewBuilder
    var feedRowView: some View {
        ForEach(postViewModel.feedListData) { data in
            LazyVStack(spacing: 0) {
                SinglePostView(postId: data.postId,
                               sentTime: data.postedAt,
                               postContent: data.context,
                               postImageURLs: data.pictureUrlList,
                               memberProfile: data.memberProfile,
                               postType: .feedView)

                VStack(alignment: .leading, spacing: 0) {
                    EmojiListView(emojiType: .feedView, postId: data.postId, feedEmojiData: data.reactionList)
                        .padding(.top, 10)
                        .onAppear {
                            postViewModel.feedEmojiData = data.reactionList
                            feedViewModel.currentPostId = data.postId
                        }
                    
                    CommentCountView(commentCount: data.commentCount)
                        .padding(.top, 10)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            feedViewModel.currentPostId = data.postId
                            viewRouter.push(FeedRouter.postDetailView)
                        }
                }
                .padding(.leading, 62)
                .padding(.bottom, 16)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundColor(.gray3)
            }
            .background(
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        feedViewModel.currentPostId = data.postId
                        viewRouter.push(FeedRouter.postDetailView)
                    }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    FeedView()
        .environment(ViewRouter())
        .environment(FeedViewModel(getReadTreehouseInfoUseCase: ReadTreehouseInfoUseCase(repository: TreehouseRepositoryImpl())))

}
