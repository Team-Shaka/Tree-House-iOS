//
//  TreehouseViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import Foundation
import Observation

@Observable
final class TreehouseViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let readMyTreehouseInfoUseCase: GetReadMyTreehouseInfoUseCaseProtocol?
    
    @ObservationIgnored
    private let createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol?
    
    @ObservationIgnored
    private let readTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol?
    
    // MARK: - Property
    
    var treehouseInfo: [ReadTreehouseInfoResponseEntity]?
    var treehouseData: ReadTreehouseInfoResponseEntity?
    var isloading: Bool = true
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(readMyTreehouseInfoUseCase: GetReadMyTreehouseInfoUseCaseProtocol? = nil,
         readTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol? = nil,
         createTreehouseUseCase: PostCreateTreehouseUseCaseProtocol? = nil) {
        self.readMyTreehouseInfoUseCase = readMyTreehouseInfoUseCase
        self.readTreehouseInfoUseCase = readTreehouseInfoUseCase
        self.createTreehouseUseCase = createTreehouseUseCase
        
        print("init TreehouseViewModel")
    }
    
    deinit {
        print("Deinit TreehouseViewModel")
    }
}

// MARK: - Treehouse API Extension

extension TreehouseViewModel {
    
    /// 내 트리하우스를 조회하는 API
    func readMyTreehouseInfo(currentTreehouseId: Int) async {
        guard let useCase = readMyTreehouseInfoUseCase else { return }
        
        let result = await useCase.execute()
        
        switch result {
        case .success(let response):
            treehouseInfo = response.treeohouses
            
            if let index = treehouseInfo?.firstIndex(where: { $0.treehouseId == currentTreehouseId }) {
                treehouseInfo?[index].currentTreeHouse = true
                isloading = false
            }
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
    
    /// 트리하우스를 생성하는 API
    func createTreehouse(treehouseName: String, treeholeName: String) async {
        guard let useCase = createTreehouseUseCase else { return }
        
        let result = await useCase.execute(request: PostCreateTreehouseRequestDTO(treehouseName: treehouseName, treeholeName: treeholeName))
        
        switch result {
        case .success(_):
            break
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
    
    /// 트리하우스를 조회하는 API
    func readTreehouseInfo(treehouseId: Int) async {
        guard let useCase = readTreehouseInfoUseCase else { return }
        
        let result = await useCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            treehouseData = response
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
}
