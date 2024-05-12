//
//  FeedContentView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/23/24.
//

import SwiftUI

struct FeedContentView: View {
    
    // MARK: - ViewModel Property
    
    var viewModel = FeedContentViewModel()
    
    // MARK: - View
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.commentModels.indices, id: \.self) { index in
                    CommentView(commentIndex: index,
                                userName: viewModel.commentModels[index].userName,
                                time: viewModel.commentModels[index].time,
                                comment: viewModel.commentModels[index].comment,
                                commentyType: .comment,
                                viewModel: viewModel)
                        .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
                    
                    replyView(replay: viewModel.commentModels[index].reply, commentIndex: index)
                        .padding(EdgeInsets(top: 10, leading: 60, bottom: 10, trailing: 16))
                }
            }
        }
    }
}

// MARK: - ViewBuilder

private extension FeedContentView {
    @ViewBuilder
    func replyView(replay: [ReplyCommentModel]?, commentIndex: Int) -> some View {
        if let data = replay {
            ForEach(Array(data.enumerated()), id: \.element.id) { replyIndex, data in
                CommentView(commentIndex: commentIndex,
                            replyIndex: replyIndex,
                            userName: data.userName,
                            time: data.time,
                            comment: data.comment,
                            commentyType: .reply,
                            viewModel: viewModel)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FeedContentView()
}
