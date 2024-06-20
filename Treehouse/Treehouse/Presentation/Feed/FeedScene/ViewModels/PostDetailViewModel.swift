//
//  PostDetailViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 6/20/24.
//

import Foundation
import SwiftUI

class PostDetailViewModel: ObservableObject {
    @Published var isEditPostPopupShowing: Bool = false
    @Published var isBottomSheetShowing: Bool = false
    @Published var isDeletePostPopupShowing: Bool = false
    @Published var sheetCase: FeedBottomSheetCase = .isWriterOnPost

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
