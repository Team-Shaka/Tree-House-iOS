//
//  PostExistsUserLoginResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/14/24.
//

import Foundation

struct PostExistsUserLoginResponseDTO: Decodable {
    let userId: Int
    let userName: String
    let profileImageUrl: String?
    let accessToken: String
    let refreshToken: String
    let treehouseIdList: [Int]

    func toDomain() -> ExistsUserLoginResponseEntity {
        return ExistsUserLoginResponseEntity(userId: userId,
                                             userName: userName,
                                             profileImageUrl: profileImageUrl,
                                             accessToken: accessToken,
                                             refreshToken: refreshToken,
                                             treehouseIdList: treehouseIdList)
    }
}
