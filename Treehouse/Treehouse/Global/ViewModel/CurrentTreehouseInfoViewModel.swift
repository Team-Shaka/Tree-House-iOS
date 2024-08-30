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
    
    var currentTreehouseId: Int?
    var treehouseName: String = ""
    var treehouseImageUrl: String = ""
    var treehouseSize: Int = 0
    var memberId: Int = 0
    
    var errorMessage: String = ""
    var isloading: Bool = true
    var isAlert: (Bool, AlertType) = (false, .logout)
    
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
            await MainActor.run {
                treehouseName = response.treehouseName
                currentTreehouseId = treehouseId
                treehouseImageUrl = response.treehouseImageUrl ?? ""
                treehouseSize = response.treehouseSize
                isloading = false
            }
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
