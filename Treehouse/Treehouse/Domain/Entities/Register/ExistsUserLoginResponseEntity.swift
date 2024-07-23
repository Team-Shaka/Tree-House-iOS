//
//  ExistsUserLoginResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct ExistsUserLoginResponseEntity: Decodable {
    let userId: Int
    let refreshToken: String
    let accessToken: String
    let treehouseIdList: [Int]
}
