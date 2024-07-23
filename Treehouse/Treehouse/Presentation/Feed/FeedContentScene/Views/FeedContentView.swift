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

    @State var emojiViewModel: EmojiViewModel = EmojiViewModel(createReactionToCommentUseCase: CreateReactionToCommentUseCase(repository: CommentRepositoryImpl()))

    // MARK: - View
    
    var body: some View {
        @Bindable var commentViewModel = commentViewModel
        
        LazyVStack(spacing: 0) {
            ForEach(commentViewModel.unwrappedReadCommentData) {
                CommentView(commentId: $0.commentId, 
                            userName: $0.memberProfile.memberName,
                            time: $0.commentedAt,
                            comment: $0.context,
                            reactionData: $0.reactionList ?? [])
                    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                
                replyView(reply: $0.replyList)
                    .padding(EdgeInsets(top: 10, leading: 60, bottom: 10, trailing: 16))
            }
        }
        .bottomSheet(isPresented: $commentViewModel.isSelectEmojiView, topPadding: 30) {
            EmojiGridView()
                .environment(emojiViewModel)
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
                            userName: $0.memberProfile.memberName,
                            time: $0.commentedAt,
                            comment: $0.context,
                            reactionData: $0.reactionList)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FeedContentView()
}
