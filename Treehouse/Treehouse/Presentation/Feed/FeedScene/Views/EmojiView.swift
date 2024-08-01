//
//  EmojiView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import SwiftUI

struct EmojiView: View {
    
    var emoji: String
    var count: Int
    var isPressed: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: 4) {
                Text(emoji)
                    .fontWithLineHeight(fontLevel: .body1)
                
                Text("\(count)")
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(isPressed ? .treeLightgreen : .gray7)
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 10)
            .background(isPressed ? .treePale : .gray1)
            .clipShape(RoundedRectangle(cornerRadius: 20.0))
            .overlay {
                if isPressed {
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(.treeLightgreen, lineWidth: 1)
                }
            }
        }
    }
}

#Preview {
    EmojiView(emoji: "😀", count: 1, isPressed: true)
}
