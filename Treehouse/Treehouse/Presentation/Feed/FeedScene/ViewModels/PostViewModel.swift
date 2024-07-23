//
//  PostViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/22/24.
//

import Foundation
import Observation

@Observable
final class PostViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private var readFeedPostUseCase: GetReadFeedPostUseCaseProtocol
    
    // MARK: - Property
    
    var feedListData =  [GetReadFeedPostListResponseEntity]()
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readFeedPostUseCase: GetReadFeedPostUseCaseProtocol) {
        self.readFeedPostUseCase = readFeedPostUseCase
        print("PostViewModel init")
    }
    
    deinit {
        print("Deinit PostViewModel")
    }
}

// MARK: - Feed API Extension

extension PostViewModel {
    func readFeedPostsList(treehouseId: Int) async {
        let result = await readFeedPostUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            feedListData = response
            break
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
