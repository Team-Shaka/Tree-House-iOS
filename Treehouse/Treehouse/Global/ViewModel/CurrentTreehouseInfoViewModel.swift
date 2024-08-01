//
//  CurrentTreehouseInfoViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/1/24.
//

import Foundation
import Observation

@Observable
final class CurrentTreehouseInfoViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    @ObservationIgnored
    private let getReadTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol
    
//    var treehouseData =
    var currentTreehouseId: Int?
    var treehouseName: String = ""
    var treehouseImageUrl: String = ""
    var userId: Int = 0
    
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(getReadTreehouseInfoUseCase: GetReadTreehouseInfoUseCaseProtocol) {
        self.getReadTreehouseInfoUseCase = getReadTreehouseInfoUseCase
        print("init ReadTreehouseInfoViewModel")
    }
    
    deinit {
        print("Deinit ReadTreehouseInfoViewModel")
    }
}

extension CurrentTreehouseInfoViewModel {
    func getReadTreehouseInfo(treehouseId: Int) async {
        let result = await getReadTreehouseInfoUseCase.execute(treehouseId: treehouseId)
        
        switch result {
        case .success(let response):
            treehouseName = response.treehouseName
            currentTreehouseId = treehouseId
            treehouseImageUrl = response.treehouseImageUrl ?? ""
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
