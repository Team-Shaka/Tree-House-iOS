//
//  CommentViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/15/24.
//

import Foundation
import Observation

enum CommentStateType {
    case createComment
    case createReplyComment
}

@Observable
final class CommentViewModel: BaseViewModel {
    
    var commentState: CommentStateType = .createComment
    var createCommentMemberName = ""
    
    var isReadCommentData: Bool = false
    
    private var readCommentData: [CommentListEntity]?
    
    var unwrappedReadCommentData: [CommentListEntity] {
        readCommentData ?? []
    }
    
    var selectedCommentId: Int?
    var postContent: String = ""
    var errorMessage: String = ""
    var isSelectEmojiView = false
    var isKeyboardShowing = false
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let createCommentUseCase: PostCreateCommentUseCaseProtocol
    
    @ObservationIgnored
    private let readCommentUseCase: GetReadCommentUseCaseProtocol
    
    @ObservationIgnored
    private let createReplyCommentUseCase: PostCreateReplyCommentUseCaseProtocol
    
    @ObservationIgnored
    private var emojiViewModel: EmojiViewModel?
    
    // MARK: - init
    
    init(createCommentUseCase: PostCreateCommentUseCaseProtocol,
         readCommentUseCase: GetReadCommentUseCaseProtocol,
         createReplyCommentUseCase: PostCreateReplyCommentUseCaseProtocol
    ) {
        self.createCommentUseCase = createCommentUseCase
        self.readCommentUseCase = readCommentUseCase
        self.createReplyCommentUseCase = createReplyCommentUseCase
    }
    
    deinit {
        print("Deinit CommentViewModel")
    }
    
    func injectionViewModel(_ emojiViewModel: BaseViewModel) {
        self.emojiViewModel = emojiViewModel as? EmojiViewModel
    }
    
    func changeEmojiData(commentId: Int, selectEmoji: String) async {
        if let commentIndex = readCommentData?.firstIndex(where: { $0.commentId == commentId }) {
            if let index = readCommentData?[commentIndex].reactionList.reactionList.firstIndex(where: { $0.reactionName == selectEmoji }) {
                if readCommentData?[commentIndex].reactionList.reactionList[index].isPushed == false {
                    readCommentData?[commentIndex].reactionList.reactionList[index].isPushed = true
                    readCommentData?[commentIndex].reactionList.reactionList[index].reactionCount += 1
                } else {
                    readCommentData?[commentIndex].reactionList.reactionList[index].isPushed = false
                    readCommentData?[commentIndex].reactionList.reactionList[index].reactionCount -= 1
                    
                    if readCommentData?[commentIndex].reactionList.reactionList[index].reactionCount == 0 {
                        readCommentData?[commentIndex].reactionList.reactionList.remove(at: index)
                    }
                }
            }
        }
    }
    
    func selectComment(_ id: Int) {
        selectedCommentId = id
    }
}

// MARK: - Comment API Extension

extension CommentViewModel {
    func createComment(treehouseId: Int, postId: Int) async -> Bool {
        let result = await createCommentUseCase.execute(treehouseId: treehouseId, postId: postId, context: postContent)
        switch result {
        case .success(_):
            await MainActor.run {
                postContent = ""
            }
            
            return true
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            return false
        }
    }

    func readComment(treehouseId: Int, postId: Int) async -> Bool {
        let result = await readCommentUseCase.execute(treehouseId: treehouseId, postId: postId)

        switch result {
        case .success(let response):
            await MainActor.run {
                readCommentData = response.commentList
            }
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return false
        }
    }
    
    func createReplyComment(treehouseId: Int, postId: Int, commentId: Int) async -> Bool {
        let result = await createReplyCommentUseCase.execute(treehouseId: treehouseId,
                                                             postId: postId,
                                                             commentId: commentId, 
                                                             context: postContent)
        
        switch result {
        case .success(_):
            await MainActor.run {
                postContent = ""
            }
            return true
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            return false
        }
    }
}
