//
//  FeedContentViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/23/24.
//

import Foundation
import Observation

@Observable
final public class FeedContentViewModel {
    
    var commentModels: [CommentModel] = [CommentModel(userName: "영서",
                                                      comment: "우와",
                                                      time: "3분 전",
                                                      reply: [ReplyCommentModel(userName: "태경", comment: "우와", time: "2분 전",
                                                                                emojiComment: [EmojiModel(emoji: "😄", count: 1, isPressed: false),
                                                                                               EmojiModel(emoji: "😢", count: 2, isPressed: false),
                                                                                               EmojiModel(emoji: "🥱", count: 3, isPressed: false)]),
                                                              ReplyCommentModel(userName: "준혁", comment: "우와", time: "1분 전",
                                                                                emojiComment: [EmojiModel(emoji: "😄", count: 1, isPressed: false),
                                                                                               EmojiModel(emoji: "😢", count: 2, isPressed: false),
                                                                                               EmojiModel(emoji: "🥱", count: 3, isPressed: false)])],
                                                      emojiComment: [EmojiModel(emoji: "😄", count: 1, isPressed: false),
                                                                     EmojiModel(emoji: "😢", count: 2, isPressed: false),
                                                                     EmojiModel(emoji: "🥱", count: 3, isPressed: false)])]
    
    /// 댓글에 대한 이모지 관련 동작
    func emojiButtonTapped(commentIndex: Int, emojiIndex: Int) {
        guard let emojiData = commentModels[commentIndex].emojiComment?[emojiIndex] else {
            return print("emoji 데이터 없음")
        }
        
        if emojiData.isPressed {
            commentModels[commentIndex].emojiComment?[emojiIndex].isPressed.toggle()
            commentModels[commentIndex].emojiComment?[emojiIndex].count -= 1
        } else {
            commentModels[commentIndex].emojiComment?[emojiIndex].isPressed.toggle()
            commentModels[commentIndex].emojiComment?[emojiIndex].count += 1
        }
    }
    
    /// 대댓글에 대한 이모지 관련 동작
    func emojiButtonTapped(commentIndex: (Int,Int?), emojiIndex: Int) {
        guard let emojiData = commentModels[commentIndex.0].reply?[commentIndex.1 ?? 0].emojiComment?[emojiIndex] else {
            return print("emoji 데이터 없음")
        }
        
        if emojiData.isPressed {
            commentModels[commentIndex.0].reply?[commentIndex.1 ?? 0].emojiComment?[emojiIndex].isPressed.toggle()
            commentModels[commentIndex.0].reply?[commentIndex.1 ?? 0].emojiComment?[emojiIndex].count -= 1
        } else {
            commentModels[commentIndex.0].reply?[commentIndex.1 ?? 0].emojiComment?[emojiIndex].isPressed.toggle()
            commentModels[commentIndex.0].reply?[commentIndex.1 ?? 0].emojiComment?[emojiIndex].count += 1
        }
    }
}
