//
//  PostExistsUserLoginResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct PostExistsUserLoginResponseDTO: Decodable {
    let userId: Int
    let accessToken: String
    let refreshToken: String
    let treehouseIdList: [Int]

    func toDomain() -> ExistsUserLoginResponseEntity {
        return ExistsUserLoginResponseEntity(userId: userId, accessToken: accessToken, refreshToken: refreshToken, treehouseIdList: treehouseIdList)
    }
}
