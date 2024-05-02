//
//  RegisterRepository.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/29/24.
//

//import Foundation
//
//final class DefaultRegisterRepository: RegisterRepository {
//    
//    var registerService: RegisterService
//    
//    public init(registerService: RegisterService) {
//        self.registerService = registerService
//    }
//    
//    func postCheckName(userName: String) async throws -> CheckNameResponseEntity? {
//        do {
//            let result = await self.registerService.postCheckName(userName)
//            switch result {
//            case .success(let data):
//                return (data as! CheckNameResponseDTO).toDomain()
//            }
//        } catch {
//            throw error
//        }
//    }
//}
