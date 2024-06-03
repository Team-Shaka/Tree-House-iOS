//
//  RegisterRepositoryProtocol.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/1/24.
//

import Foundation

protocol RegisterRepositoryProtocol {
    func postCheckName(userName: String) async throws -> CheckNameResponseEntity
    func postRegisterUser(phoneNumber: String, userName: String) async -> Result<RegisterUserResponseEntity, NetworkError> //RegisterUserResponseEntity
}
