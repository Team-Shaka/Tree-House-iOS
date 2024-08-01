//
//  ModifyMyProfileViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/1/24.
//

import Foundation
import Observation

@Observable
final class ModifyMyProfileViewModel: BaseViewModel {
    
    @ObservationIgnored
    private let modifyMyProfileUseCase: PatchModifyMyProfileUseCaseProtocol
    
    var memberName: String = ""
    var memberBio: String = ""
    var memberProfileUrl: String = ""
    var errorMessage: String = ""
    
    init(modifyMyProfileUseCase: ModifyMyProfileUseCase) {
        self.modifyMyProfileUseCase = modifyMyProfileUseCase
    }
}

extension ModifyMyProfileViewModel {
    func modifyMyProfile(treehouseId: Int) async {
        
        let requestBody = PatchModifyMyProfileRequestDTO(memberName: memberName,
                                                         bio: memberBio,
                                                         profileImageURL: memberProfileUrl)
        
        let result = await modifyMyProfileUseCase.execute(treehouseId: treehouseId, requsetBody: requestBody)
        
        switch result {
        case .success(let response):
            response.memberId
            break
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
    }
}
