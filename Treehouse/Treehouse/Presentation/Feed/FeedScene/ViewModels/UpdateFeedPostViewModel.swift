//
//  UpdateFeedPostViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import Foundation
import Observation

final class UpdateFeedPostViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let updateFeedPostUseCase: PatchUpdateFeedPostUseCaseProtocol
    
    var errorMessage: String = ""
    var isUpdatePost = false
    
    // MARK: - init
    
    init(updateFeedPostUseCase: PatchUpdateFeedPostUseCaseProtocol) {
        self.updateFeedPostUseCase = updateFeedPostUseCase
    }
    
    deinit {
        print("Deinit EmojiViewModel")
    }
}

extension UpdateFeedPostViewModel {
    func updateFeedPost(treehouseId: Int, postId: Int, context: String) async {
        let result = await updateFeedPostUseCase.execute(treehouseId: treehouseId, postId: postId, context: context)
        
        switch result {
        case .success(_):
            isUpdatePost = true
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
            
            isUpdatePost = false
        }
    }
}
