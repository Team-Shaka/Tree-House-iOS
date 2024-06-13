//
//  RegisterUserResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/3/24.
//

import Foundation

struct RegisterUserResponseEntity: Decodable {
    let userId: Int
    let refreshToken: String
    let accessToken: String
}
