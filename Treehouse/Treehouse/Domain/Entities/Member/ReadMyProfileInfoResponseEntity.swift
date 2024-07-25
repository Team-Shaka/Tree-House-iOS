//
//  ReadMyProfileInfoResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct ReadMyProfileInfoResponseEntity: Decodable {
    let memberId: Int
    let memberName: String
    let userName: String
    let closestMemberCount: Int
    let treehouseCount: Int
    let fromMe: Int
    let profileImageUrl: String
    let bio: String
}
