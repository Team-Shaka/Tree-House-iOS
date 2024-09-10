//
//  PostRegisterFCMTokenResponseDTO.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/10/24.
//

import Foundation

struct PostRegisterFCMTokenResponseDTO: Decodable {
    let userId: Int
    let saveFcmToken: Bool
    
    func toDomain() -> RegisterFCMTokenResponseEntity {
        return RegisterFCMTokenResponseEntity(userId: userId, saveFcmToken: saveFcmToken)
    }
}
