//
//  MemberGroupStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/11/24.
//

import Foundation
import SwiftUI

struct MemberGroupStruct: Hashable, Identifiable {
    let id = UUID()
    
    private var groupImageName: String
    var groupImage: Image {
        Image(groupImageName)
    }
    let groupName: String
    let personnel: Int
}

extension MemberGroupStruct {
    static let memberGroupStructDummyData: [MemberGroupStruct] = [
        MemberGroupStruct(groupImageName: "img_group", groupName: "분당팟", personnel: 20),
        MemberGroupStruct(groupImageName: "img_group", groupName: "알고리즘 스터디", personnel: 10),
        MemberGroupStruct(groupImageName: "img_group", groupName: "면접 스터디", personnel: 15),
        MemberGroupStruct(groupImageName: "img_group", groupName: "교포팟", personnel: 13),
    ]
}
