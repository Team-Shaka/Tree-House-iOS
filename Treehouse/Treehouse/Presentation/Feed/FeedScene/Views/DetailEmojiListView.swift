//
//  DetailEmojiListView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import SwiftUI

enum DetailEmojiListType {
    case feedView
    case commentView
}

struct DetailEmojiListView: View {
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (PostDetailViewModel.self) var postDetailViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    @Environment (CommentViewModel.self) var commentViewModel
    
    var emojiType: DetailEmojiListType
    var postId: Int?
    var commentId: Int?
    var emojiData: ReactionListDataEntity?
    
    // MARK: - init
    
    init(emojiType: DetailEmojiListType, postId: Int, emojiData: ReactionListDataEntity) {
        self.emojiType = emojiType
        commentId = nil
        self.postId = postId
        self.emojiData = emojiData
    }
    
    init(emojiType: DetailEmojiListType, postId: Int, commentId: Int, emojiData: ReactionListDataEntity) {
        self.emojiType = emojiType
        self.commentId = commentId
        self.postId = postId
        self.emojiData = emojiData
    }
    
    // MARK: - View
    
    var body: some View {
        FlowlayoutStack(verticalSpacing: 8, horizontalSpacing: 10) {
            switch emojiType {
            case .feedView:
                if var data = emojiData {
                    ForEach(data.reactionList) { emoji in
                        Button(action: {
                            emojiViewModel.selectEmoji = emoji.reactionName
                            Task {
                                let result = await emojiViewModel.createReactionPost(
                                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                    postId: postId ?? 0
                                )
                                
                                if result {
                                    await postDetailViewModel.changeEmojiData(postId: postId ?? 0, selectEmoji: emoji.reactionName)
                                }
                            }
                        }) {
                            EmojiView(emoji: emoji.reactionName,
                                      count: emoji.reactionCount,
                                      isPressed: emoji.isPushed)
                        }
                    }
                }
            case .commentView:
                if var data = emojiData {
                    ForEach(data.reactionList) { emoji in
                        Button(action: {
                            emojiViewModel.selectEmoji = emoji.reactionName
                            Task {
                                let result = await emojiViewModel.createReactionComment(
                                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                    postId: feedViewModel.currentPostId ?? 0,
                                    commentId: commentId ?? 0
                                )
                                
                                if result {
                                    await commentViewModel.changeEmojiData(commentId: commentId ?? 0, selectEmoji: emoji.reactionName)
                                }
                            }
                        }) {
                            EmojiView(emoji: emoji.reactionName,
                                      count: emoji.reactionCount,
                                      isPressed: emoji.isPushed)
                        }
                    }
                }
            }
            
            Button(action: {
                switch emojiType  {
                case .feedView:
                    emojiViewModel.isSelectFeedEmojiView = true
                case .commentView:
                    emojiViewModel.isSelectCommentEmojiView = true
                    feedViewModel.currentCommentId = commentId
                }
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.gray5)
                    .padding(9)
                    .frame(width:30, height: 30)
                    .background(.gray1)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

//#Preview {
//    DetailEmojiListView()
//}
