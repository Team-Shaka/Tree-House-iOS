//
//  ColorEmojiPopover.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/12/24.
//

import SwiftUI

struct ColorEmojiPopover: View {
    
    // MARK: - Property
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    
    let selectEmoji: EmojiDatas
    var emojiType: EmojiListType
    
    var commentId: Int?
    var postId: Int?
    
    @Binding var isPresented: Bool
    
    init(selectEmoji: EmojiDatas, emojiType: EmojiListType, postId: Int, isPresented: Binding<Bool>) {
        self.selectEmoji = selectEmoji
        self.emojiType = emojiType
        commentId = nil
        self.postId = postId
        self._isPresented = isPresented
    }
    
    init(selectEmoji: EmojiDatas, emojiType: EmojiListType, commentId: Int, isPresented: Binding<Bool>) {
        self.selectEmoji = selectEmoji
        self.emojiType = emojiType
        self.commentId = commentId
        postId = nil
        self._isPresented = isPresented
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                isPresented.toggle()
                Task {
                    await emojiTappedAction()
                }
            }) {
                Text(selectEmoji.unicodeEmoji)
            }
            
            Divider()
            
            ForEach(selectEmoji.color) { emojiData in
                Button(action: {
                    isPresented.toggle()
                    Task {
                        emojiViewModel.selectEmoji = emojiData.unicodeEmoji
                        await emojiTappedAction()
                    }
                }) {
                    Text(emojiData.unicodeEmoji)
                }
            }
        }
        .font(.system(size: 30))
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }
    
    func emojiTappedAction() async {
        Task {
            switch emojiType {
            case .feedView:
                let result = await emojiViewModel.createReactionPost(
                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                    postId: postId ?? 0
                )
                
            case .detailView:
                let result = await emojiViewModel.createReactionComment(
                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                    postId: feedViewModel.currentPostId ?? 0,
                    commentId: feedViewModel.currentCommentId ?? 0
                )
            }
            
            switch emojiType {
            case .feedView:
                feedViewModel.isSelectEmojiView = false
                emojiViewModel.isSelectFeedEmojiView = false
            case .detailView:
                emojiViewModel.isSelectCommentEmojiView = false
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    ColorEmojiPopover(selectEmoji: EmojiDatas(unicode: "U+1F590",
//                                              description: "hand with fingers splayed",
//                                              descriptionKorea: "손가락을 벌린 손",
//                                              color: [EmojiColorDatas(unicode: "U+1F590 U+1F3FB", 
//                                                                      description: "hand with fingers splayed: light skin tone",
//                                                                      descriptionKorea: "손가락을 벌린 손: 밝은 피부톤")]
//                                             ))
//}
