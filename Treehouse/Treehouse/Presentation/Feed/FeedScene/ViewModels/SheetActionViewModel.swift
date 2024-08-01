//
//  SheetActionViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 6/20/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class SheetActionViewModel: BaseViewModel {
    
    // MARK: - Property
    
    var isEditPostPopupShowing: Bool = false
    var isBottomSheetShowing: Bool = false
    var isDeletePostPopupShowing: Bool = false
    var isDeleteCommentPopupShwing: Bool = false
    var isReportCommentPopupShwing: Bool = false
    
    var isCompleteDeleteComment: Bool = false
    var isCompleteReportComment: Bool = false
    
    var sheetCase: FeedBottomSheetCase = .isWriterOnPost
    var postContent: String = ""
    
    var treehouseId: Int?
    var postId: Int?
    var commentId: Int?
    var memberId: Int?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let deleteCommentUseCase: DeleteCommentUseCaseProtocol?
    
    @ObservationIgnored
    private let reportCommentUseCase: PostReportCommentUseCaseProtocol?
    
    // MARK: - init
    
    init(deleteCommentUseCase: DeleteCommentUseCaseProtocol? = nil, reportCommentUseCase: PostReportCommentUseCaseProtocol? = nil) {
        self.deleteCommentUseCase = deleteCommentUseCase
        self.reportCommentUseCase = reportCommentUseCase
    }
    
    func handleSheetAction(_ action: String) {
        switch action {
        case "editPost":
            // TODO: - 포스트 수정하기 액션
            print("포스트 수정하기")
            isEditPostPopupShowing = true
            
        case "deletePost":
            // TODO: - 포스트 삭제하기 액션
            print("포스트 삭제하기")
            isDeletePostPopupShowing = true
            
        case "reportPost":
            // TODO: - 신고하기 액션
            print("신고하기")
            
        case "blockPost":
            // TODO: - 차단하기 액션
            print("차단하기")
            
        case "deleteComment":
            if let treehouseId = treehouseId,  let postId = postId, let commentId = commentId {
                Task {
                    let result = await deleteCommentUseCase?.execute(treehouseId: treehouseId, postId: postId, commentId: commentId)
                    
                    switch result {
                    case .success:
                        isCompleteDeleteComment = true
                    case .failure(let error):
                        break
                    case .none:
                        break
                    }
                }
            }
            
        case "reportComment":
            if let treehouseId = treehouseId,  let postId = postId, let commentId = commentId, let memberId = memberId {
                Task {
                    let result = await reportCommentUseCase?.execute(treehouseId: treehouseId, postId: postId, commentId: commentId, memberId: memberId)
                    
                    switch result {
                    case .success:
                        isCompleteReportComment = true
                        
                    case .failure(let error):
                        break
                    case .none:
                        break
                    }
                }
            }
            
        default:
            break
        }
        
        isBottomSheetShowing = false
    }
}
