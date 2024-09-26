//
//  FeedViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 5/9/24.
//

import Foundation
import Observation

@Observable
final class FeedViewModel: BaseViewModel {
    var viewState : FeedViewStateType = .notEmpty
    var feedData: FeedModel? = nil
    var groupName: String = ""
    
    var errorMessage: String = ""
    
    var treehouseName: String = ""
    
    var isSelectEmojiView = false
    
    var dataLoaded = false
    
    var selectTreehouseMemberId = 0
    
    /// Feed 의 Post 내용이 바뀌었을때 다시 내용을 로드하기 위한 변수
    var modifyPostContent: (Int, String) = (0, "")
    var selectEmoji: String?
    
    @ObservationIgnored
    var selectPostId: Int?
    
    @ObservationIgnored
    var currentTreehouseId: Int?
    
    @ObservationIgnored
    var currentPostId: Int?
    
    @ObservationIgnored
    var currentCommentId: Int?
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let getReadTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol
    
    // MARK: - init
    
    init(getReadTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol) {
        self.getReadTreehouseInfoUseCase = getReadTreehouseInfoUseCase
        
        print("init FeedViewModel")
    }
    
    deinit {
        print("Deinit FeedViewModel")
    }
}

extension FeedViewModel {
    func getReadTreehouseInfo(treehouseId: Int) async {
        let result = await getReadTreehouseInfoUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            treehouseName = response.treehouseName
            currentTreehouseId = treehouseId
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
