//
//  CreateTreehouseViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/7/24.
//

import Foundation

final class CheckTreehouseNameViewModel: BaseViewModel {
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let checkTreehouseNameUseCase: PostCheckTreehouseNameUseCaseProtocol

    // MARK: - Property
    
    var treehouseName: String = ""
    var isAvailable: Bool = false
    var errorMessage: String = ""
    
    // MARK: - init
    
    init(checkTreehouseNameUseCase: PostCheckTreehouseNameUseCaseProtocol) {
        self.checkTreehouseNameUseCase = checkTreehouseNameUseCase
    }
}

extension CheckTreehouseNameViewModel {
    func postCheckTreehouseName() async {
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
}
