//
//  RegisterFCMTokenResponseEntity.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation

struct RegisterFCMTokenResponseEntity: Decodable {
    let userId: Int
    let saveFcmToken: Bool
}
