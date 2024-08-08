//
//  AvailableInvitationViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

final class CreateTreehouseViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol
    
    // MARK: - Property
    
    var treehouseName: String
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol, treehouseName: String) {
        self.createTreehouseUseCase = createTreehouseUseCase
        self.treehouseName = treehouseName
    }
}

extension CreateTreehouseViewModel {
    func createTreehouse() async -> Int? {
        print(treehouseName)
        let result = await createTreehouseUseCase.execute(request: PostCreateTreehouseRequestDTO(treehouseName: treehouseName, treeholeName: "아요"))
        
        switch result {
        case .success(let response):
            print("API 성공: ", response.treehouseId)
            return response.treehouseId
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            return nil
        }
    }
}
