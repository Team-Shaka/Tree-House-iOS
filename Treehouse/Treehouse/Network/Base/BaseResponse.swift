//
//  BaseResponse.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var isSuccess: Bool
    var code: String
    var message: String
    var data: T
    var createdAt: String?
}
