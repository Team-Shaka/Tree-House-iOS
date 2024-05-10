//
//  BaseResponse.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

struct BaseResponse<T> {
    var isSuccess: Bool
    var code: String
    var message: String
    var createdAt: String?
    var data: T
}
