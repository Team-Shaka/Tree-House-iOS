//
//  CheckNameRequestDTO.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/27/24.
//

import Foundation

struct CheckNameRequestDTO: Codable {
    let userName: String
    
    init(checkNameRequestEntity: CheckNameRequestEntity) {
        self.userName = checkNameRequestEntity.userName
    }
}
