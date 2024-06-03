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
    
    func postRegisterUser(phoneNumber: String, userName: String) async -> Result<RegisterUserResponseEntity, NetworkError> {
        do {
            let response = try await registerService.postRegisterUser(phoneNumber: phoneNumber, userName: userName)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
