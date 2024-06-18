//
//  PostPresignedURLRequestDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

struct PostPresignedURLRequestDTO: Codable {
    let fileName: String
    let fileSize: Int
}
