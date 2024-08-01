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
    @Attribute(.unique) let userId: Int
    var userName: String
    var profileImageUrl: String
    var treehouses: [Int] = []
    @Relationship(deleteRule: .cascade) var treehouseInfo: [TreehouseInfo] = []
    
    init(userId: Int, userName: String, profileImageUrl: String, treehouses: [Int], treehouseInfo: [TreehouseInfo]) {
        self.userId = userId
        self.userName = userName
        self.profileImageUrl = profileImageUrl
        self.treehouses = treehouses
        self.treehouseInfo = treehouseInfo
    }
}

@Model
class TreehouseInfo {
    var treehouseId: Int
    var treehouseMemberId: Int
    var treehouseName: String
    var bio: String
    var profileImageUrl: URL?
    @Relationship(inverse: \UserInfoData.treehouseInfo) var user: UserInfoData?
    
    init(treehouseId: Int, treehouseMemberId: Int, treehouseName: String, bio: String, profileImageUrl: URL?) {
        self.treehouseId = treehouseId
        self.treehouseMemberId = treehouseMemberId
        self.treehouseName = treehouseName
        self.bio = bio
        self.profileImageUrl = profileImageUrl
    }
}

extension UserInfoData {
    func findTreehouse(id: Int) -> TreehouseInfo? {
        return treehouseInfo.first { $0.treehouseId == id }
    }
}
