//
//  UserInfoData.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/27/24.
//

import SwiftData
import SwiftUI

@Model
class UserInfoData {
    var userId: Int
    var userName: String
    var treeMemberName: String
    var treehouseId: [Int: String]
    var bio: String
    @Attribute(.externalStorage)
    var profileImageData: Data
    
    init(userId: Int, userName: String, treeMemberName: String, treehouseId: [Int: String], bio: String, profileImageData: Data) {
        self.userId = userId
        self.userName = userName
        self.treeMemberName = treeMemberName
        self.treehouseId = treehouseId
        self.bio = bio
        self.profileImageData = profileImageData
    }
}
