//
//  FeedRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/21/24.
//

import SwiftUI

enum FeedRouter: Router {
    typealias ContentView = AnyView
    
    case postDetailView
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        if let viewModel = viewModel as? FeedViewModel {
            switch self {
            case .postDetailView:
                return AnyView(
                    PostDetailView(
                        commentViewModel: CommentViewModel(
                            createCommentUseCase: CreateCommentUseCase(
                                repository: CommentRepositoryImpl()),
                            readCommentUseCase: ReadCommentUseCase(
                                repository: CommentRepositoryImpl()), 
                            createReplyCommentUseCase: CreateReplyCommentUseCase(
                                repository: CommentRepositoryImpl()
                            )
                        )
                    )
                    .environment(viewModel)
                )
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}
