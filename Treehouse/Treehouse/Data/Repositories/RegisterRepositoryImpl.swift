//
//  RegisterRepositoryImpl.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/29/24.
//

import Foundation

final class RegisterRepositoryImpl: RegisterRepositoryProtocol {
    private var registerService = RegisterService()
    
    func postCheckName(userName: String) async throws -> CheckNameResponseEntity {
        do {
            let response = try await registerService.postCheckName(userName: userName)
            return response.toDomain()
        } catch {
            throw error
        }
    }
}
