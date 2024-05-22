//
//  PostReportFeedCommentRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PostReportFeedCommentRequestDTO: Codable {
    let reason: String
    let targetMemberId: String
}
