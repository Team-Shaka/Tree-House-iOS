//
//  PostRegisterTreeMemberRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct PostRegisterTreeMemberRequestDTO: Codable {
    let treehouseId: Int
    let userName: String
    let memberName: String
    let bio: String
    let profileImageURL: String
}
