//
//  FeedContentView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/23/24.
//

import SwiftUI

struct FeedContentView: View {
    
    // MARK: - ViewModel Property
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (CommentViewModel.self) var commentViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    var focusedField: FocusState<FeedField?>.Binding

//    @State var emojiViewModel: EmojiViewModel = EmojiViewModel(createReactionToCommentUseCase: CreateReactionToCommentUseCase(repository: CommentRepositoryImpl()))

    // MARK: - View
    
    var body: some View {
        @Bindable var commentViewModel = commentViewModel
        
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(commentViewModel.unwrappedReadCommentData) { comment in
                CommentView(commentId: comment.commentId,
                            userProfile: comment.memberProfile,
                            time: comment.commentedAt,
                            comment: comment.context,
                            reactionData: comment.reactionList)
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
//                    .environment(emojiViewModel)
                
                replyView(reply: comment.replyList)
                    .padding(EdgeInsets(top: 10, leading: 60, bottom: 10, trailing: 16))
                
                Button(action: {
                    feedViewModel.currentCommentId = comment.commentId
                    focusedField.wrappedValue = .post
                    commentViewModel.createCommentMemberName = comment.memberProfile.memberName
                    commentViewModel.commentState = .createReplyComment
                }) {
                    Text("답글 달기")
                        .fontWithLineHeight(fontLevel: .body4)
                        .foregroundStyle(.treeGreen)
                }
                .padding(.leading, 60)
            }
        }
        .onAppear {
            commentViewModel.injectionViewModel(emojiViewModel)
        }
    }
}

// MARK: - ViewBuilder

private extension FeedContentView {
    @ViewBuilder
    func replyView(reply: [ReplyListEntity]?) -> some View {
        if let data = reply {
            ForEach(data) {
                CommentView(commentId: $0.commentId,
                            userProfile: $0.memberProfile,
                            time: $0.commentedAt,
                            comment: $0.context,
                            reactionData: $0.reactionList)
                .environment(emojiViewModel)
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    FeedContentView()
//}
