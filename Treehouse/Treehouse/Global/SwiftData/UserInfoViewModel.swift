//
//  UserInfoViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/27/24.
//

import Observation
import Foundation
import UIKit


@Observable
final class UserInfoViewModel: BaseViewModel {
    
    @ObservationIgnored
    private let dataSource: UserInfoDataSource

    var userInfo: UserInfoData?

    init(dataSource: UserInfoDataSource = UserInfoDataSource.shared) {
        self.dataSource = dataSource
        self.userInfo = dataSource.fetchItem()
    }
    
    /// UserInfoData 를 처음으로 만들기 위한 메서드
    func createData(newData: UserInfoData) async -> Bool {
        print("User Data 저장")
        removeData()
        userInfo = newData
        return insertData(data: newData)
    }

    /// treememberName 을 수정하기 위한 메서드
    func modifyMemberName(treehouseId: Int, memberName: String) -> Bool {
        if let treehouse = userInfo?.findTreehouse(id: treehouseId) {
            treehouse.treehouseName = memberName
        }

        return updateData()
    }
    
    /// profile 을 수정하기 위한 메서드
    func modifyProfileImage(treehouseId: Int, imageUrl: String) -> Bool {
        if let treehouse = userInfo?.findTreehouse(id: treehouseId) {
            treehouse.profileImageUrl = URL(string: imageUrl)
        }
    
        return updateData()
    }

    /// bio 를 수정하기 위한 메서드
    func modifyBio(treehouseId: Int, bio: String) -> Bool {
        if let treehouse = userInfo?.findTreehouse(id: treehouseId) {
            treehouse.bio = bio
        }
        
        return updateData()
    }
    
    /// treehouse 를 추가하기 위한 메서드
    func modifyTreehouse(treehouseId: Int) -> Bool {
        if let data = userInfo {
            data.treehouses.append(treehouseId)
        }
        
        return updateData()
    }
    
    /// TreehouseInfo 추가하기 위한 메서드
    func addTreehouseInfo(treehouseInfo: TreehouseInfo) -> Bool {
        let _ = modifyTreehouse(treehouseId: treehouseInfo.treehouseId)
        
        if let data = userInfo {
            data.treehouseInfo.append(treehouseInfo)
        }
        
        return updateData()
    }
    
    /// User 정보를 지우기 위한 메서드
    func deleteMyData() {
        removeData()
    }
}

// MARK: - UserInfoDataSource 와 연관되어 있는 메서드

private extension UserInfoViewModel {
    /// 새로운 데이터를 저장하기 위한 메서드
    func insertData(data: UserInfoData) -> Bool {
        let result = dataSource.insertUserInfo(data: data)
        return result
    }
    
    /// 이미 저장된 데이터를 수정하기 위해 다시 저장하는 메서드
    func updateData() -> Bool {
        guard let _ = userInfo else { return false }
        
        switch dataSource.saveUserInfo() {
        case .success(let result):
            return result
        case .failure(let error):
            print(error)
            return false
        }
    }

    func removeData() {
        guard let data = userInfo else { return }
        print("데이터 삭제")
        dataSource.removeUserInfo(data: data)
        userInfo = nil
    }
}
