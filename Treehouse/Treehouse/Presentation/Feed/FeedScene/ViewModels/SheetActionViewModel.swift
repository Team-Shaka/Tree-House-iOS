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
    var sheetCase: FeedBottomSheetCase = .isWriterOnPost
    var postContent: String = ""

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
            // TODO: - 댓글 삭제하기 액션
            print("댓글 삭제하기")
            
        case "reportComment":
            // TODO: - 댓글 신고하기 액션
            print("댓글 신고하기")
            
        default:
            break
        }
        
        isBottomSheetShowing = false
    }
}
