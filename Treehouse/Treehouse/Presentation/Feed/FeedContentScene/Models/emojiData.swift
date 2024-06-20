//
//  emojiData.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/12/24.
//

import Foundation

struct EmojiDatas: Codable, Identifiable {
    let id: UUID = UUID()
    let unicode: String
    let description: String
    let descriptionKorea: String
    let color: [EmojiColorDatas]
    
    var unicodeEmoji: String {
        let scalars = unicode.split(separator: " ").compactMap {
            UnicodeScalar(Int($0.dropFirst(2), radix: 16)!)
        }
        return String(String.UnicodeScalarView(scalars))
    }
    
    enum CodingKeys: String, CodingKey {
        case unicode
        case description
        case descriptionKorea = "description_korea"
        case color
    }
}

struct EmojiColorDatas: Codable, Identifiable {
    let id: UUID = UUID()
    let unicode: String
    let description: String
    let descriptionKorea: String
    
    var unicodeEmoji: String {
        let scalars = unicode.split(separator: " ").compactMap {
            UnicodeScalar(Int($0.dropFirst(2), radix: 16)!)
        }
        return String(String.UnicodeScalarView(scalars))
    }
    
    enum CodingKeys: String, CodingKey {
        case unicode
        case description
        case descriptionKorea = "description_korea"
    }
}
