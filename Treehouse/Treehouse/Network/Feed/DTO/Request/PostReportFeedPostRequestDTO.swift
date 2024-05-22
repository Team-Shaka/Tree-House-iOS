//
//  PostReportFeedPostRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PostReportFeedPostRequestDTO: Codable {
    let reason: String
    let targetMemberId: Int
}
