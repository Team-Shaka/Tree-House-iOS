//
//  PostReissueTokenResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostReissueTokenResponseDTO: Decodable {
    let refreshToken: String
    let accessToken: String
}
