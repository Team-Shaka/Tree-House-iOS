//
//  UserInfoData.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/27/24.
//

import SwiftData

@Model
class UserInfoData {
    var userId: Int
    var userName: String
    var treeMemberName: String
    var treehouseId: [Int]
    var bio: String
    
    init(userId: Int, userName: String, treeMemberName: String, treehouseId: [Int], bio: String) {
        self.userId = userId
        self.userName = userName
        self.treeMemberName = treeMemberName
        self.treehouseId = treehouseId
        self.bio = bio
    }
}
