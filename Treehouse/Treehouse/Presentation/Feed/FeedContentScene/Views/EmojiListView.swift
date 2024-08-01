//
//  EmojiListView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/23/24.
//

import SwiftUI

enum EmojiListType {
    case feedView
    case detailView
}

struct EmojiListView: View {
    
    // MARK: - ViewModel Property
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    @Environment (PostViewModel.self) var postViewModel
    
    // MARK: - Property
    
    var emojiType: EmojiListType
    var commentId: Int?
    var postId: Int?
    var feedEmojiData: ReactionListDataEntity?
    var detailEmojiData: ReactionListDataEntity?
    
    // MARK: - init
    
    init(emojiType: EmojiListType, postId: Int, feedEmojiData: ReactionListDataEntity) {
        self.emojiType = emojiType
        commentId = nil
        self.postId = postId
        self.feedEmojiData = feedEmojiData
    }
    
    init(emojiType: EmojiListType, commentId: Int, detailEmojiData: ReactionListDataEntity) {
        self.emojiType = emojiType
        self.commentId = commentId
        postId = nil
        self.detailEmojiData = detailEmojiData
    }

    // MARK: - View
    
    var body: some View {
        FlowlayoutStack(verticalSpacing: 8, horizontalSpacing: 10) {
            if let data = feedEmojiData {
                ForEach(data.reactionList) { emoji in
                    Button(action: {
                        emojiViewModel.selectEmoji = emoji.reactionName
                        Task {
                            let result = await emojiViewModel.createReactionPost(
                                treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                postId: postId ?? 0
                            )
                            
                            if result {
                                await postViewModel.changeEmojiData(postId: postId ?? 0, selectEmoji: emoji.reactionName)
                            }
                        }
                    }) {
                        EmojiView(emoji: emoji.reactionName,
                                  count: emoji.reactionCount,
                                  isPressed: emoji.isPushed)
                    }
                }
            }

            Button(action: {
                feedViewModel.isSelectEmojiView = true
                feedViewModel.currentPostId = postId
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

// MARK: - ViewBuilder

private extension EmojiListView {
//    @ViewBuilder
//    func emojiView(_ emoji: String, _ count: Int, _ isPressed: Bool) -> some View {
//        ZStack {
//            HStack(spacing: 4) {
//                Text(emoji)
//                    .fontWithLineHeight(fontLevel: .body1)
//                
//                Text("\(count)")
//                    .fontWithLineHeight(fontLevel: .body5)
//                    .foregroundStyle(isPressed ? .treeLightgreen : .gray7)
//            }
//            .padding(.vertical, 2)
//            .padding(.horizontal, 10)
//            .background(isPressed ? .treePale : .gray1)
//            .clipShape(RoundedRectangle(cornerRadius: 20.0))
//            .overlay {
//                if isPressed {
//                    RoundedRectangle(cornerRadius: 20.0)
//                        .stroke(.treeLightgreen, lineWidth: 1)
//                }
//            }
//        }
//    }
}

// MARK: - Preview

//#Preview {
//    EmojiListView(emojiData: [EmojiModel(emoji: "😄", count: 124, isPressed: false),
//                              EmojiModel(emoji: "😢", count: 2, isPressed: false),
//                              EmojiModel(emoji: "🥱", count: 3, isPressed: false)],
//                  index: (0,0),
//                  viewModel: FeedContentViewModel())
//}
