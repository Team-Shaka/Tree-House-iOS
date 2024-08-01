//
//  ReadMyTreehouseInfoResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import Foundation

struct ReadMyTreehouseInfoResponseEntity: Decodable {
    let treeohouses: [ReadTreehouseInfoResponseEntity]
}
