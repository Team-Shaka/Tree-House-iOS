//
//  PhoneNumberStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/21/24.
//

import Foundation

struct UserPhoneNumberInfo: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    let profileImage: Data?
    var isInvitation: Bool
}

extension UserPhoneNumberInfo {
    static let phoneNumberStructDummyData: [UserPhoneNumberInfo] = [
        UserPhoneNumberInfo(name: "음바페", phoneNumber: "010-0XXX-XXXX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "라모스", phoneNumber: "010-X0XX-XXXX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "크로스", phoneNumber: "010-XX0X-XXXX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "뎀벨레", phoneNumber: "010-XXX0-XXXX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "데폴", phoneNumber: "010-XXXX-0XXX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "파머", phoneNumber: "010-XXXX-X0XX", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "케인", phoneNumber: "010-XXXX-XX0X", profileImage: nil, isInvitation: false),
        UserPhoneNumberInfo(name: "비르츠", phoneNumber: "010-XXXX-XXX0", profileImage: nil, isInvitation: false)
    ]
}
