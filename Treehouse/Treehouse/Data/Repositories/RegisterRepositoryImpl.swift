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
    
    func postRegisterTreeMember(requestDTO: PostRegisterTreeMemberRequestDTO) async -> Result<RegisterTreeMemberResponseEntity, NetworkError> {
        do {
            let response = try await registerService.postRegisterTreeMember(requestBody: requestDTO)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postCheckUserPhone(phoneNumber: String) async -> Result<CheckUserPhoneResponseEntity, NetworkError> {
        do {
            let response = try await registerService.postCheckUserPhone(phoneNumber: phoneNumber)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postExistsUserLogin(phoneNumber: String) async -> Result<ExistsUserLoginResponseEntity, NetworkError> {
        do {
            let response = try await registerService.postExistsUserLogin(phoneNumber: phoneNumber)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postRegisterFCMToken(token: String) async -> Result<RegisterFCMTokenResponseEntity, NetworkError>  {
        do {
            let response = try await registerService.postRegisterFCMToken(token: token)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func postRegisterPushAgree(pushAgree: Bool) async -> Result<RegisterPushAgreeResponseEntity, NetworkError> {
        do {
            let response = try await registerService.postRegisterPushAgree(pushAgree: pushAgree)
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
    
    func deleteUser() async -> Result<DeleteUserResponseEntity, NetworkError> {
        do {
            let response = try await registerService.deleteUser()
            return .success(response.toDomain())
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
