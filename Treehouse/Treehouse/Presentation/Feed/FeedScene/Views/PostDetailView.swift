//
//  PostDetailView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/7/24.
//

import SwiftUI
import PopupView

struct PostDetailView: View {
    
    // MARK: - State Property
    
    @Environment (ViewRouter.self) var viewRouter
    @Environment (FeedViewModel.self) var feedViewModel
    
    @State var commentViewModel: CommentViewModel
    
    @State var postDetailViewModel = PostDetailViewModel(readDetailFeedPostUseCase: ReadDetailFeedPostUseCase(repository: FeedRepositoryImpl()))
    @State var emojiViewModel: EmojiViewModel = EmojiViewModel(createReactionToCommentUseCase: CreateReactionToCommentUseCase(repository: CommentRepositoryImpl()), createReactionToPostUseCase: CreateReactionToPostUseCase(repository: FeedRepositoryImpl()))
    @State private var userInfoViewModel = UserInfoViewModel()
    @State var viewModel: SheetActionViewModel = SheetActionViewModel()
    
    @State private var postContent: String = ""
    @State private var textFieldState: TextFieldStateType = .notFocused
    
    @FocusState private var focusedField: FeedField?
    @FocusState private var isKeyboardShowing: Bool
    
    @State var isloading = true
//    @GestureState private var dragOffset = CGSize.zero
    
    // MARK: - View
    
    var body: some View {
        @Bindable var commentViewModel = commentViewModel
        
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    if let postId = feedViewModel.currentPostId, let postDetailData = postDetailViewModel.detailFeedListData {
                    
                        VStack {
                            SinglePostView(sentTime: postDetailData.postedAt,
                                           postContent: postDetailData.context,
                                           postImageURLs: postDetailData.pictureUrlList,
                                           memberProfile: postDetailData.memberProfile,
                                           postType: .DetailView)
                            
                            DetailEmojiListView(emojiType: .feedView, postId: postDetailData.postId, emojiData: postDetailData.reactionList)
                                .padding(.top, 10)
                                .padding(.leading, 62)
                                .environment(postDetailViewModel)
                                .environment(emojiViewModel)
                                .environment(commentViewModel)
                        }
                    } else {
                        SinglePostView(sentTime: "",
                                       postContent: "정보없음",
                                       postImageURLs: [""],
                                       memberProfile: MemberProfileEntity(memberId: 0, memberName: "", memberProfileImageUrl: "", memberBranch: 0),
                                       postType: .DetailView)
                    }
                    
                    Divider()
                        .padding(.top, 16)
                    
                    if !(commentViewModel.unwrappedReadCommentData.isEmpty) {
                        FeedContentView(focusedField: $focusedField)
                            .environment(commentViewModel)
                            .environment(emojiViewModel)
                            .environment(postDetailViewModel)
                    }
                }.refreshable {
                    await performAsyncTasks()
                }
                
                feedDetailTextField
                    .onChange(of: focusedField) { _, newValue in
                        if newValue == .post {
                            textFieldState = .enable
                        } else {
                            textFieldState = .notFocused
                        }
                    }
                
                if viewModel.isDeletePostPopupShowing {
                    deletePostPopupView
                } else if viewModel.isDeleteCommentPopupShwing {
                    
                }
            }
            .background(.grayscaleWhite)
            .redacted(reason: isloading ? .placeholder : [])
        }
        .onTapGesture {
            commentViewModel.commentState = .createComment
            commentViewModel.createCommentMemberName = postDetailViewModel.detailFeedListData?.memberProfile.memberName ?? ""
            hideKeyboard()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("게시글")
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(.treeBlack)
            }
        }
        .popup(isPresented: $emojiViewModel.isSelectFeedEmojiView) {
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
        .popup(isPresented: $emojiViewModel.isSelectCommentEmojiView) {
            if feedViewModel.currentPostId != nil {
                EmojiGridView(emojiType: .detailView, commentId: feedViewModel.currentCommentId ?? 0)
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
        .onAppear {
            Task {
                await performAsyncTasks()
                commentViewModel.createCommentMemberName = postDetailViewModel.detailFeedListData?.memberProfile.memberName ?? ""
            }
        }
    }
    
    func performAsyncTasks() async {
        async let readDetail = postDetailViewModel.readDetailFeedPost(
            treehouseId: feedViewModel.currentTreehouseId ?? 0,
            postId: feedViewModel.currentPostId ?? 0
        )
        
        async let readComments = commentViewModel.readComment(
            treehouseId: feedViewModel.currentTreehouseId ?? 0,
            postId: feedViewModel.currentPostId ?? 0
        )
        
        // 모든 비동기 작업이 완료될 때까지 기다립니다
        let (detailResult, commentResult) = await (readDetail, readComments)
        
        if detailResult && commentResult {
            isloading = false
        }
    }
}

// MARK: - ViewBuilder

extension PostDetailView {
    @ViewBuilder
    var feedDetailTextField: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray3)
            
            HStack(alignment: .bottom, spacing: 10) {
                CustomAsyncImage(url: userInfoViewModel.userInfo?.treehouseInfo[feedViewModel.currentTreehouseId ?? 0].profileImageUrl?.absoluteString ?? "",
                                 type: .postMemberProfileImage,
                                 width: 36,
                                 height: 36)
                    .clipShape(Circle())
                
                ZStack(alignment: .trailing) {
                    TextField("\(commentViewModel.createCommentMemberName)에게 댓글쓰기", text: $commentViewModel.postContent, axis: .vertical)
                        .padding(EdgeInsets(top: 12.0, leading: 14.0, bottom: 12.0, trailing: 50.0))
                        .fontWithLineHeight(fontLevel: .body5)
                        .tint(.treeGreen)
                        .foregroundColor(textFieldState.fontColor)
                        .focused($focusedField, equals: .post)
                        .focused($isKeyboardShowing)
                        .keyboardType(.default)
                        .textInputAutocapitalization(.never)
                        .lineLimit(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(.gray4, lineWidth: 1)
                        )
                    
                    if textFieldState == .enable {
                        Button(action: {
                            Task {
                                if let treehouseId = feedViewModel.currentTreehouseId, let postId = feedViewModel.currentPostId {
                                    switch commentViewModel.commentState {
                                    case .createComment:
                                        let result = await commentViewModel.createComment(treehouseId: treehouseId, postId: postId)
                                        
                                        if result {
                                            await MainActor.run {
                                                hideKeyboard()
                                            }
                                            await performAsyncTasks()
                                        }
                                    case .createReplyComment:
                                        if let commentId = feedViewModel.currentCommentId {
                                            let result = await commentViewModel.createReplyComment(treehouseId: treehouseId, 
                                                                                                   postId: postId,
                                                                                                   commentId: commentId)
                                            if result {
                                                feedViewModel.currentCommentId = nil
                                                await MainActor.run {
                                                    hideKeyboard()
                                                }
                                                await performAsyncTasks()
                                            }
                                        }
                                    }
                                }
                            }
                        }) {
                            Image(.icReply)
                        }
                        .padding(.trailing, 7)
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.bottom, 8)
            .padding(.trailing, 16)
        }
        .background(.grayscaleWhite)
    }
    
    @ViewBuilder
    var deletePostPopupView: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            Spacer()
            
            PostAlertView(
                alertContent: "작성한 포스트를 삭제하시겠어요?",
                onCancel: {
                    viewModel.isDeletePostPopupShowing = false
                },
                onConfirm: {
                    viewModel.isDeletePostPopupShowing = false
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

#Preview {
    NavigationStack {
        PostDetailView(
            commentViewModel: CommentViewModel(
                createCommentUseCase: CreateCommentUseCase(
                    repository: CommentRepositoryImpl()
                ),
                readCommentUseCase: ReadCommentUseCase(
                    repository: CommentRepositoryImpl()
                ), 
                createReplyCommentUseCase: CreateReplyCommentUseCase(
                    repository: CommentRepositoryImpl()
                )
            )
        )
        .environment(
            ViewRouter()
        )
    }
}
