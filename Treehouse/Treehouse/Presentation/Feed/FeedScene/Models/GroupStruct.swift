//
//  GroupStruct.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/25/24.
//

import Foundation
import SwiftUI

struct GroupStruct: Hashable, Identifiable {
    let id = UUID()
    
    private var groupImageName: String
    var groupImage: Image {
        Image(groupImageName)
    }
    let groupName: String
    let personnel: Int
    let currentTreeHouse: Bool
}

extension GroupStruct {
    static let groupStructDummyData: [GroupStruct] = [
        GroupStruct(groupImageName: "img_group", groupName: "분당팟", personnel: 20, currentTreeHouse: true),
        GroupStruct(groupImageName: "img_group", groupName: "알고리즘 스터디", personnel: 20, currentTreeHouse: false),
        GroupStruct(groupImageName: "img_group", groupName: "면접 스터디", personnel: 20, currentTreeHouse: false),
        GroupStruct(groupImageName: "img_group", groupName: "교포팟", personnel: 20, currentTreeHouse: false),
    ]
}
