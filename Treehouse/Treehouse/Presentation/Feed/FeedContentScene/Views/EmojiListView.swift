//
//  EmojiListView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/23/24.
//

import SwiftUI

struct EmojiListView: View {
    
    // MARK: - Property
    
    var emojiData: [EmojiModel]
    let commentType: CommentType
    var index: (Int,Int?)
    
    // MARK: - State Property

    @Bindable var viewModel: FeedContentViewModel
    
    // MARK: - View
    
    var body: some View {
        FlowlayoutStack(verticalSpacing: 8, horizontalSpacing: 10) {
            ForEach(emojiData.indices, id: \.self) { emojiIndex in
                Button(action: {
                    switch commentType {
                    case .comment:
                        viewModel.emojiButtonTapped(commentIndex: index.0, emojiIndex: emojiIndex)
                    case .reply:
                        viewModel.emojiButtonTapped(commentIndex: index, emojiIndex: emojiIndex)
                    }
                }) {
                    emojiView(emojiData[emojiIndex].emoji,
                              emojiData[emojiIndex].count,
                              emojiData[emojiIndex].isPressed)
                }
            }

            Button(action: {
                
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.gray5)
                    .padding(9)
                    .frame(width:30, height: 30)
                    .background(.gray1)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
            }
        }
    }
}

// MARK: - ViewBuilder

private extension EmojiListView {
    @ViewBuilder
    func emojiView(_ emoji: String, _ count: Int, _ isPressed: Bool) -> some View {
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

// MARK: - Preview

#Preview {
    EmojiListView(emojiData: [EmojiModel(emoji: "😄", count: 124, isPressed: false),
                              EmojiModel(emoji: "😢", count: 2, isPressed: false),
                              EmojiModel(emoji: "🥱", count: 3, isPressed: false)],
                  commentType: .comment,
                  index: (0,0),
                  viewModel: FeedContentViewModel())
}
