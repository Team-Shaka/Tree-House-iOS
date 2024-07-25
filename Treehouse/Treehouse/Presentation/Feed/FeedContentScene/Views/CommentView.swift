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
    
    // MARK: - ViewModel Property

    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (CommentViewModel.self) var commentViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    
    // MARK: - Property
    
    let commentId: Int
    var replyIndex: Int? = nil
    let userName: String
    let time: String
    let comment: String
    var reactionData: [ReactionListEntity]
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(.icNotiMember)
                .frame(width: 36, height: 36)
                .padding(.trailing, 10)
//                .padding(.trailing, commentyType == .comment ? 8 : 10)
            
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
                
                EmojiListView(emojiType: .detailView, emojiArrayData: reactionData, commentId: commentId)
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    CommentView(replyIndex: 0,
//                userName: "영서",
//                time: "3분 전",
//                comment: "댓글을 입력해주세요.", reactionData: <#[ReactionListEntity]?#>
//                viewModel: CommentViewModel(createCommentUseCase: CreateCommentUseCase(repository: FeedRepositoryImpl()), readCommentUseCase: ReadCommentUseCase(repository: FeedRepositoryImpl())))
//}
