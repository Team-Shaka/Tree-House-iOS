//
//  PostViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation
import Observation
import UIKit

@Observable
final class PostViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private var readFeedPostUseCase: GetReadFeedPostUseCaseProtocol
    
    @ObservationIgnored
    private var createFeedPostsUseCase: PostCreateFeedPostsUseCaseProtocol
    
    // MARK: - Property
    
    var feedListData =  [GetReadFeedPostListResponseEntity]()
    var feedEmojiData: ReactionListDataEntity?
    var detailEmojiData: [ReactionListEntity]?
    
    var postContent: String = ""
    var selectImage: [UIImage] = []
    var errorMessage: String = ""
    
    var isLoading = false
    
    // MARK: - init
    
    init(readFeedPostUseCase: GetReadFeedPostUseCaseProtocol,
         createFeedPostsUseCase: PostCreateFeedPostsUseCaseProtocol
    ) {
        self.readFeedPostUseCase = readFeedPostUseCase
        self.createFeedPostsUseCase = createFeedPostsUseCase
        print("PostViewModel init")
    }
    
    deinit {
        print("Deinit PostViewModel")
    }
    
    func changeEmojiData(postId: Int, selectEmoji: String) async {
        if let postIndex = feedListData.firstIndex(where: { $0.postId == postId }) {
            if let index = feedListData[postIndex].reactionList.reactionList.firstIndex(where: { $0.reactionName == selectEmoji }) {
                if feedListData[postIndex].reactionList.reactionList[index].isPushed == false {
                    feedListData[postIndex].reactionList.reactionList[index].isPushed = true
                    feedListData[postIndex].reactionList.reactionList[index].reactionCount += 1
                } else {
                    feedListData[postIndex].reactionList.reactionList[index].isPushed = false
                    feedListData[postIndex].reactionList.reactionList[index].reactionCount -= 1
                    
                    if feedListData[postIndex].reactionList.reactionList[index].reactionCount == 0 {
                        feedListData[postIndex].reactionList.reactionList.remove(at: index)
                    }
                }
            } else {
                feedListData[postIndex].reactionList.reactionList.append(ReactionListEntity(reactionName: selectEmoji, reactionCount: 1, isPushed: true))
            }
        }
    }
    
    func changePostContent(postId: Int, content: String) -> Bool {
        if let index = feedListData.firstIndex(where: { $0.postId == postId }) {
            feedListData[index].context = content
            return true
        } else {
            return false
        }
    }
}

// MARK: - Feed API Extension

extension PostViewModel {
    func readFeedPostsList(treehouseId: Int) async -> Bool {
        let result = await readFeedPostUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            feedListData = response
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isLoading = true
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
    
    func createFeedPost(treehouseId: Int, context: String, pictureUrlList: [PresignedURLResponseEntity]) async -> Bool {
        
        let accessUrlData = pictureUrlList.map { $0.accessUrl }
        
        let result = await createFeedPostsUseCase.execute(treehouseId: treehouseId, requestBody: PostCreateFeedPostsRequestDTO(context: context, pictureUrlList: accessUrlData))
        
        switch result {
        case .success(let response):
            
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
