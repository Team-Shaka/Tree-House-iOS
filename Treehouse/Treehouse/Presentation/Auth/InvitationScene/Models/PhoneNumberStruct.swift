//
//  PhoneNumberStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/21/24.
//

import Foundation

struct PhoneNumberStruct: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
}
