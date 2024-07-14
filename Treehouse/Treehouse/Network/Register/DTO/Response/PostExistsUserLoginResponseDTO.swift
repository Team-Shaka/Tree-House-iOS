//
//  PostExistsUserLoginResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct PostExistsUserLoginResponseDTO: Decodable {
    let userId: Int
    let refreshToken: String
    let accessToken: String
    let treehouseIdList: [Int]

    func toDomain() -> ExistsUserLoginResponseEntity {
        return ExistsUserLoginResponseEntity(userId: userId, refreshToken: refreshToken, accessToken: accessToken, treehouseIdList: treehouseIdList)
    }
}
