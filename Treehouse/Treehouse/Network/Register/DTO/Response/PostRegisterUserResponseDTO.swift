//
//  PostRegisterUserResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostRegisterUserResponseDTO: Decodable {
    let userId: Int
    let refreshToken: String
    let accessToken: String
}
