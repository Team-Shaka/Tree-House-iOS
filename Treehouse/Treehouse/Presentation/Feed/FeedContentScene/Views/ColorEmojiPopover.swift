//
//  ColorEmojiPopover.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/12/24.
//

import SwiftUI

struct ColorEmojiPopover: View {
    let selectEmoji: EmojiDatas
    
    var body: some View {
        HStack(spacing: 10) {
            Button(action: {

            }) {
                Text(selectEmoji.unicodeEmoji)
            }
            
            Divider()
            
            ForEach(selectEmoji.color) { emojiData in
                Button(action: {

                }) {
                    Text(emojiData.unicodeEmoji)
                }
            }
        }
        .font(.system(size: 30))
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }
}

#Preview {
    ColorEmojiPopover(selectEmoji: EmojiDatas(unicode: "U+1F590",
                                              description: "hand with fingers splayed",
                                              descriptionKorea: "손가락을 벌린 손",
                                              color: [EmojiColorDatas(unicode: "U+1F590 U+1F3FB", 
                                                                      description: "hand with fingers splayed: light skin tone",
                                                                      descriptionKorea: "손가락을 벌린 손: 밝은 피부톤")]
                                             ))
}
