//
//  RegisterPushAgreeResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation

struct RegisterPushAgreeResponseEntity: Decodable {
    let userId: Int
    let pushAgree: Bool
}
