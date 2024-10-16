//
//  ExistsUserLoginResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct ExistsUserLoginResponseEntity: Decodable {
    let userId: Int
    let userName: String
    let profileImageUrl: String?
    let accessToken: String
    let refreshToken: String
    let treehouseIdList: [Int]
}
