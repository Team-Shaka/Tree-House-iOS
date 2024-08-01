//
//  EmojiViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/17/24.
//

import Foundation
import Observation

@Observable
final class EmojiViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let createReactionToCommentUseCase: PostCreateReactionToCommentUseCaseProtocol?
    
    @ObservationIgnored
    private let createReactionToPostUseCase: PostCreateReactionToPostUseCaseProtocol?
    
    // MARK: - Property
    
    var emojis = [EmojiDatas]()
    var selectEmoji: String? {
        didSet {
            self.selectEmoji
        }
    }
    var errorMessage: String = ""
    
    var feedEmojiData: ReactionListDataEntity? {
        didSet {
            print(feedEmojiData?.reactionList)
        }
    }
    var detailEmojiData: [ReactionListEntity]?
    
    var isSelectFeedEmojiView = false
    var isSelectCommentEmojiView = false
    
    // MARK: - init
    
    init(createReactionToCommentUseCase: PostCreateReactionToCommentUseCaseProtocol? = nil, createReactionToPostUseCase: PostCreateReactionToPostUseCaseProtocol? = nil) {
        self.createReactionToCommentUseCase = createReactionToCommentUseCase
        self.createReactionToPostUseCase = createReactionToPostUseCase
    }
    
    deinit {
        print("Deinit EmojiViewModel")
    }
}
    
extension EmojiViewModel {
    func loadEmojis() {
        guard let url = Bundle.main.url(forResource: "structuredEmojis", withExtension: "json") else {
            print("JSON 파일이 존재하지 않습니다.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodeData = try JSONDecoder().decode([EmojiDatas].self, from: data)
            DispatchQueue.main.async {
                self.emojis = decodeData
            }
        } catch {
            print("JSON 파일 디코딩 실패: \(error)")
        }
    }
}

// MARK: - Comment API Extension

extension EmojiViewModel {
    func createReactionPost(treehouseId: Int, postId: Int) async -> Bool {
        guard let selectEmoji = selectEmoji, let useCase = createReactionToPostUseCase else { return false }
        
        let result = await useCase.execute(
            treehouseId: treehouseId,
            postId: postId,
            requestDTO: PostReactionFeedPostRequestDTO(reactionName: selectEmoji)
        )
        
        switch result {
        case .success(_):
            await MainActor.run {
                self.selectEmoji = nil
            }
            
            return true
            
        case .failure(let error):
            await MainActor.run {
                self.selectEmoji = nil
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            
            return false
        }
    }
    
    func createReactionComment(treehouseId: Int, postId: Int, commentId: Int) async -> Bool {
        guard let selectEmoji = selectEmoji, let useCase = createReactionToCommentUseCase else { return false }
        
        let result = await useCase.execute(
            treehouseId: treehouseId,
            postId: postId,
            commentId: commentId,
            reactionName: selectEmoji
        )
        
        switch result {
        case .success(_):
            await MainActor.run {
                self.selectEmoji = nil
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
