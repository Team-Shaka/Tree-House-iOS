//
//  CommentModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/24/24.
//

import Foundation

struct CommentModel: Identifiable, Decodable {
    var id = UUID()
    let userName: String
    let comment: String
    let time: String
    var reply: [ReplyCommentModel]?
    var emojiComment: [EmojiModel]?
}

struct ReplyCommentModel: Identifiable, Decodable {
    var id = UUID()
    let userName: String
    let comment: String
    let time: String
    var emojiComment: [EmojiModel]?
}

struct EmojiModel: Identifiable, Decodable {
    var id = UUID()
    let emoji: String
    var count: Int
    var isPressed: Bool
}
