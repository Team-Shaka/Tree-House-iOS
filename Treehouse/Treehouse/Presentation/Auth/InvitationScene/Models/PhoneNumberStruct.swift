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

extension PhoneNumberStruct {
    static let PhoneNumberStructDummyData: [PhoneNumberStruct] = [
        PhoneNumberStruct(name: "음바페", phoneNumber: "010-0XXX-XXXX"),
        PhoneNumberStruct(name: "라모스", phoneNumber: "010-X0XX-XXXX"),
        PhoneNumberStruct(name: "크로스", phoneNumber: "010-XX0X-XXXX"),
        PhoneNumberStruct(name: "뎀벨레", phoneNumber: "010-XXX0-XXXX"),
        PhoneNumberStruct(name: "데폴", phoneNumber: "010-XXXX-0XXX"),
        PhoneNumberStruct(name: "파머", phoneNumber: "010-XXXX-X0XX"),
        PhoneNumberStruct(name: "케인", phoneNumber: "010-XXXX-XX0X"),
        PhoneNumberStruct(name: "비르츠", phoneNumber: "010-XXXX-XXX0")
    ]
}
