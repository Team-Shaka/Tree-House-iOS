//
//  PostDetailViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/23/24.
//

import Foundation
import Observation

@Observable
final class PostDetailViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private var readDetailFeedPostUseCase: GetReadDetailFeedPostUseCaseProtocol
    
    // MARK: - Property

    var detailFeedListData: GetReadDetailFeedPostResponseEntity?
    
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readDetailFeedPostUseCase: GetReadDetailFeedPostUseCaseProtocol) {
        self.readDetailFeedPostUseCase = readDetailFeedPostUseCase
        print("init PostDetailViewModel")
    }
    
    deinit {
        print("Deinit PostDetailViewModel")
    }
    
    func changeEmojiData(postId: Int, selectEmoji: String) async {
        if let index = detailFeedListData?.reactionList.reactionList.firstIndex(where: { $0.reactionName == selectEmoji }) {
            if detailFeedListData?.reactionList.reactionList[index].isPushed == false {
                detailFeedListData?.reactionList.reactionList[index].isPushed = true
                detailFeedListData?.reactionList.reactionList[index].reactionCount += 1
            } else {
                detailFeedListData?.reactionList.reactionList[index].isPushed = false
                detailFeedListData?.reactionList.reactionList[index].reactionCount -= 1
                
                if detailFeedListData?.reactionList.reactionList[index].reactionCount == 0 {
                    detailFeedListData?.reactionList.reactionList.remove(at: index)
                }
            }
        } else {
            detailFeedListData?.reactionList.reactionList.append(ReactionListEntity(reactionName: selectEmoji, reactionCount: 1, isPushed: true))
        }
    }
}

// MARK: - Feed API Extension

extension PostDetailViewModel {
    func readDetailFeedPost(treehouseId: Int, postId: Int) async -> Bool {
        let result = await readDetailFeedPostUseCase.execute(treehouseId: treehouseId, postId: postId)
        
        switch result {
        case .success(let response):
            await MainActor.run {
                detailFeedListData = response
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
