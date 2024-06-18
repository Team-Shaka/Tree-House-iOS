//
//  PresignedURLResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

struct PresignedURLResponseEntity: Decodable {
    let presignedUrl: String
    let accessUrl: String
}
