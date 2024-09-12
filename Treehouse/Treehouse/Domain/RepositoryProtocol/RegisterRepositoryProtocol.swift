//
//  RegisterRepositoryProtocol.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/1/24.
//

import Foundation

protocol RegisterRepositoryProtocol {
    func postCheckName(userName: String) async throws -> CheckNameResponseEntity
    func postRegisterUser(phoneNumber: String, userName: String) async -> Result<RegisterUserResponseEntity, NetworkError>
    func postRegisterTreeMember(registerType: RegisterType, requestDTO: PostRegisterTreeMemberRequestDTO) async -> Result<RegisterTreeMemberResponseEntity, NetworkError>
    func postCheckUserPhone(phoneNumber: String) async -> Result<CheckUserPhoneResponseEntity, NetworkError>
    func postExistsUserLogin(phoneNumber: String) async -> Result<ExistsUserLoginResponseEntity, NetworkError>
    func postRegisterFCMToken(token: String) async -> Result<RegisterFCMTokenResponseEntity, NetworkError>
    func postRegisterPushAgree(pushAgree: Bool) async -> Result<RegisterPushAgreeResponseEntity, NetworkError>
    func deleteUser() async -> Result<DeleteUserResponseEntity, NetworkError>
}
