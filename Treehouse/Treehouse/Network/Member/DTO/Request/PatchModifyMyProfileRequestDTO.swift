//
//  PatchModifyMyProfileRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

struct PatchModifyMyProfileRequestDTO: Codable {
    let memberName: String
    let bio: String
    let profileImageURL: String
}
