//
//  CommentView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/24/24.
//

import SwiftUI

enum CommentType {
    case comment
    case reply
}

struct CommentView: View {
    
    // MARK: - ViewModel Property

    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (CommentViewModel.self) var commentViewModel
    @Environment (PostDetailViewModel.self) var postDetailViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    @State private var viewModel = SheetActionViewModel(deleteCommentUseCase: DeleteCommentUseCase(repository: CommentRepositoryImpl()), reportCommentUseCase: ReportCommentUseCase(repository: CommentRepositoryImpl()))
    
    // MARK: - Property
    
    let commentType: CommentType
    let commentId: Int
    var replyIndex: Int? = nil
    let userProfile: MemberProfileEntity
    let time: String
    let comment: String
    var reactionData: ReactionListDataEntity
    var focusedField: FocusState<FeedField?>.Binding
    var isReplayList: Bool
    var lastData: Bool?
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            CustomAsyncImage(url: userProfile.memberProfileImageUrl ?? "",
                              type: .postMemberProfileImage,
                              width: 36,
                              height: 36)
                .clipShape(Circle())
                .padding(.trailing, 10)
//                .padding(.trailing, commentyType == .comment ? 8 : 10)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 1) {
                    HStack(alignment: .center) {
                        Text(userProfile.memberName)
                            .fontWithLineHeight(fontLevel: .body2)
                            .foregroundStyle(.grayscaleBlack)
                            .padding(.trailing, 6)
                        
                        Text("branch \(time)")
                            .fontWithLineHeight(fontLevel: .caption1)
                            .foregroundStyle(.gray5)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.memberId = userProfile.memberId
                            
                            if userProfile.memberId == feedViewModel.userId {
                                viewModel.sheetCase = .isWriterOnComment
                            } else {
                                viewModel.sheetCase = .isReaderOnComment
                            }
                            
                            viewModel.isBottomSheetShowing.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray5)
                        }
                    }
                    
                    Text(comment)
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.grayscaleBlack)
                }
                .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                .background(.gray1)
                .selectCornerRadius(radius: 12.0, corners: [.bottomLeft, .bottomRight, .topRight])
                
                DetailEmojiListView(emojiType: .commentView, postId: feedViewModel.currentPostId ?? 0, commentId: commentId, emojiData: reactionData)
                    .environment(commentViewModel)
                    
                if isReplayList == false && commentType == .comment {
                    Button(action: {
                        feedViewModel.currentCommentId = commentId
                        focusedField.wrappedValue = .post
                        commentViewModel.createCommentMemberName = userProfile.memberName
                        commentViewModel.commentState = .createReplyComment
                    }) {
                        Text("답글 달기")
                            .fontWithLineHeight(fontLevel: .body4)
                            .foregroundStyle(.treeGreen)
                    }
                } else if isReplayList == true && commentType == .reply && lastData == true {
                    Button(action: {
                        feedViewModel.currentCommentId = commentId
                        focusedField.wrappedValue = .post
                        commentViewModel.createCommentMemberName = userProfile.memberName
                        commentViewModel.commentState = .createReplyComment
                    }) {
                        Text("답글 달기")
                            .fontWithLineHeight(fontLevel: .body4)
                            .foregroundStyle(.treeGreen)
                    }
                }
            }
        }
        .onAppear {
            viewModel.treehouseId = feedViewModel.currentTreehouseId
            viewModel.postId = feedViewModel.currentPostId
            viewModel.commentId = commentId
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
    }
}

// MARK: - Preview

//#Preview {
//    CommentView(replyIndex: 0,
//                userName: "영서",
//                time: "3분 전",
//                comment: "댓글을 입력해주세요.", reactionData: <#[ReactionListEntity]?#>
//                viewModel: CommentViewModel(createCommentUseCase: CreateCommentUseCase(repository: FeedRepositoryImpl()), readCommentUseCase: ReadCommentUseCase(repository: FeedRepositoryImpl())))
//}
