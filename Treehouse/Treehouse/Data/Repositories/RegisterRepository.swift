//
//  RegisterRepository.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/29/24.
//

import Foundation

protocol RegisterRepository {
    
    func postCheckName(checkNameResponseDTO: CheckNameResponseDTO) async -> CheckNameResponseEntity?
}

class DefaultRegisterRepository: RegisterRepository {
    
    var checkNameService: CheckNameService
    
    public init(checkNameService: CheckNameService) {
        self.checkNameService = checkNameService
    }
    
    func postCheckName(checkNameResponseDTO: CheckNameResponseDTO) async -> CheckNameResponseEntity? {
        let result = await self.checkNameService.postCheckName(checkNameResponseDTO: checkNameResponseDTO)
        guard case .success(let data) = result else {
            return nil
        }
        return (data as! CheckNameResponseDTO).toDomain()
    }
}
