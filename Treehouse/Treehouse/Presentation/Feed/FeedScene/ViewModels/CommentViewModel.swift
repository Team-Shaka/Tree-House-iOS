//
//  CommentViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/15/24.
//

import Foundation
import Observation

@Observable
final class CommentViewModel: BaseViewModel {
    
    var isReadCommentData: Bool = false
    
    private var readCommentData: [CommentListEntity]?
    
    var unwrappedReadCommentData: [CommentListEntity] {
        readCommentData ?? []
    }
    
    var postContent: String = ""
    var errorMessage: String = ""
    var isSelectEmojiView = false
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let createCommentUseCase: PostCreateCommentUseCaseProtocol
    
    @ObservationIgnored
    private let readCommentUseCase: GetReadCommentUseCaseProtocol
    
    @ObservationIgnored
    private var emojiViewModel: EmojiViewModel?
    
    // MARK: - init
    
    init(createCommentUseCase: PostCreateCommentUseCaseProtocol,
         readCommentUseCase: GetReadCommentUseCaseProtocol
    ) {
        self.createCommentUseCase = createCommentUseCase
        self.readCommentUseCase = readCommentUseCase
    }
    
    deinit {
        print("Deinit CommetViewModel")
    }
    
    func injectionViewModel(_ emojiViewModel: BaseViewModel) {
        self.emojiViewModel = emojiViewModel as? EmojiViewModel
    }
    
    func changeReactionState() {
        let emoji = emojiViewModel?.selectEmoji
    }
}

// MARK: - Comment API Extension

extension CommentViewModel {
    func createComment(treehouseId: Int, postId: Int) async {
        let result = await createCommentUseCase.execute(treehouseId: treehouseId, postId: postId, context: postContent)
        switch result {
        case .success(let response):
            break
//            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
//            return false
        }
    }
//    
    func readComment(treehouseId: Int, postId: Int) async {
        let result = await readCommentUseCase.execute(treehouseId: treehouseId, postId: postId)
//
        switch result {
        case .success(let response):
            readCommentData = response.commentList
//            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
//            return false
        }
    }
}
