//
//  CommentView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/24/24.
//

import SwiftUI

enum CommentType {
    case comment
    case reply
}

struct CommentView: View {
    
    // MARK: - Property
    
    let commentIndex: Int
    var replyIndex: Int? = nil
    let userName: String
    let time: String
    let comment: String
    let commentyType: CommentType
    
    // MARK: - ViewModel Property
    
    @Bindable var viewModel: FeedContentViewModel
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(.icNotiMember)
                .frame(width: 36, height: 36)
                .padding(.trailing, commentyType == .comment ? 8 : 10)
            
            VStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 1) {
                    HStack(alignment: .center) {
                        Text(userName)
                            .fontWithLineHeight(fontLevel: .body2)
                            .foregroundStyle(.grayscaleBlack)
                            .padding(.trailing, 6)
                        
                        Text("branch \(time)")
                            .fontWithLineHeight(fontLevel: .caption1)
                            .foregroundStyle(.gray5)
                        
                        Spacer()
                        
                        Button(action: {
                            
                        }) {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.gray5)
                        }
                    }
                    
                    Text(comment)
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.grayscaleBlack)
                }
                .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
                .background(.gray1)
                .selectCornerRadius(radius: 12.0, corners: [.bottomLeft, .bottomRight, .topRight])
                
                commentyTypeEmojiListView
            }
        }
    }
}

// MARK: - ViewBuilder

private extension CommentView {
    @ViewBuilder
    var commentyTypeEmojiListView: some View {
        switch commentyType {
        case .comment:
            if let data = viewModel.commentModels[commentIndex].emojiComment {
                EmojiListView(emojiData: data,
                              commentType: .comment,
                              index: (commentIndex, nil),
                              viewModel: viewModel)
            }
        case .reply:
            if let data = viewModel.commentModels[commentIndex].reply?[replyIndex ?? 0].emojiComment {
                EmojiListView(emojiData: data,
                              commentType: .reply,
                              index: (commentIndex, replyIndex ?? 0),
                              viewModel: viewModel)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CommentView(commentIndex: 0,
                replyIndex: 0,
                userName: "영서",
                time: "3분 전",
                comment: "댓글을 입력해주세요.",
                commentyType: .comment,
                viewModel: FeedContentViewModel())
}
