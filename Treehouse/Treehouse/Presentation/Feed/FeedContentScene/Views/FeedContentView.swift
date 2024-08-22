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

    // MARK: - View
    
    var body: some View {
        @Bindable var commentViewModel = commentViewModel
        
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(commentViewModel.unwrappedReadCommentData) { comment in
                CommentView(commentType: .comment,
                            commentId: comment.commentId,
                            userProfile: comment.memberProfile,
                            time: comment.commentedAt,
                            comment: comment.context,
                            reactionData: comment.reactionList,
                            focusedField: focusedField,
                            isReplayList: !comment.replyList.isEmpty)
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                replyView(reply: comment.replyList)
                    .padding(EdgeInsets(top: 10, leading: 60, bottom: 10, trailing: 16))
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
                CommentView(commentType: .reply,
                            commentId: $0.commentId,
                            userProfile: $0.memberProfile,
                            time: $0.commentedAt,
                            comment: $0.context,
                            reactionData: $0.reactionList, 
                            focusedField: focusedField,
                            isReplayList: true,
                            lastData: $0.commentId == data.last?.commentId)
                .environment(emojiViewModel)
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    FeedContentView()
//}
