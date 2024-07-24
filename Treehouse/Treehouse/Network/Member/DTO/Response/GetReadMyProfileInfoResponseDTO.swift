//
//  GetReadMyProfileInfo.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadMyProfileInfoResponseDTO: Decodable{
    let memberId: Int
    let memberName: String
    let userName: String
    let closestMemberCount: Int
    let treehouseCount: Int
    let fromMe: Int
    let profileImageUrl: String
    let bio: String
    
    func toDomain() -> ReadMyProfileInfoResponseEntity {
        return ReadMyProfileInfoResponseEntity(
            memberId: memberId,
            memberName: memberName,
            userName: userName,
            closestMemberCount: closestMemberCount,
            treehouseCount: treehouseCount,
            fromMe: fromMe,
            profileImageUrl: profileImageUrl,
            bio: bio
        )
    }
}
