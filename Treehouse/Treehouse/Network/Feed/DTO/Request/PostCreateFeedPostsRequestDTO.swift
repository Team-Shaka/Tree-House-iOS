//
//  PostCreateFeedPostsRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

struct PostCreateFeedPostsRequestDTO: Codable {
    let context: String
    let pictureUrlList: [String]
}
