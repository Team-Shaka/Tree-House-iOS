//
//  AvailableInvitationViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation
import Observation

@Observable
final class CreateTreehouseViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkTreehouseNameUseCase: PostCheckTreehouseNameUseCaseProtocol
    
    @ObservationIgnored
    private let createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol
    
    // MARK: - Property
    
    var treehouseName: String = ""
    var treehouseHallName: String = ""
    var isAvailable: Bool = false
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(checkTreehouseNameUseCase: PostCheckTreehouseNameUseCaseProtocol,
        createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol) {
        self.checkTreehouseNameUseCase = checkTreehouseNameUseCase
        self.createTreehouseUseCase = createTreehouseUseCase
        
        print("init CreateTreehouseViewModel")
    }
    
    deinit {
        print("Deinit CreateTreehouseViewModel")
    }
}

extension CreateTreehouseViewModel {
    
    /// 트리하우스 이름의 중복성을 확인하는 API
    func postCheckTreehouseName() async {
        print(treehouseName)
        let result = await checkTreehouseNameUseCase.execute(treehouseName: treehouseName)
        
        switch result {
        case .success(let response):
            await MainActor.run {
                isAvailable = response.isAvailable
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
    
    func createTreehouse() async -> Int? {
        print(treehouseName)
        let result = await createTreehouseUseCase.execute(request: PostCreateTreehouseRequestDTO(treehouseName: treehouseName, treeholeName: treehouseHallName))
        
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
