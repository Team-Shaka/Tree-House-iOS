//
//  RegisterRepositoryProtocol.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/1/24.
//

import Foundation

protocol RegisterRepositoryProtocol {
    func postCheckName(userName: String) async throws -> CheckNameResponseEntity
}
