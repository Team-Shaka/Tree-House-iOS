//
//  GetReadMemberInfoResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct GetReadMemberInfoResponseDTO: Decodable {
    let memberId: Int
    let memberName: String
    let userName: String
    let closetMemberCount: Int
    let treehouseCount: Int
    let fromeMe: Int
    let profileImageUrl: String
    let bio: String
}
