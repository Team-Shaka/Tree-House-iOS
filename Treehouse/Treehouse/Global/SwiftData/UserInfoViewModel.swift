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

    private var userInfo: UserInfoData? {
        didSet {
            print("새로 바뀐 값: \(userInfo)")
        }
    }
    
    var safeUserInfo: UserInfoData {
        userInfo ?? UserInfoData(userId: 0, userName: "Unknown", treeMemberName: "Unknown", treehouseId: [Treehouse(treehouseId: 0, treehouseName: "")], bio: "Unknown", profileImageData: Data())
    }

    init(dataSource: UserInfoDataSource = UserInfoDataSource.shared) {
        self.dataSource = dataSource
        self.userInfo = dataSource.fetchItem()
    }
    
    /// UserInfoData 를 처음으로 만들기 위한 메서드
    func createData(newData: UserInfoData) -> Bool {
        userInfo = newData
        return insertData(data: safeUserInfo)
    }

    /// treememberName 을 수정하기 위한 메서드
    func modifyMemberName(memberName: String) -> Bool {
        userInfo?.treeMemberName = memberName
        return updateData()
    }
    
    func modifyProfileImage(imageData: UIImage) -> Bool {
        guard let data = imageData.pngData() else { return false }
        userInfo?.profileImageData = data
        return updateData()
    }

    /// bio 를 수정하기 위한 메서드
    func modifyBio(bio: String) -> Bool {
        userInfo?.bio = bio
        return updateData()
    }
}

// MARK: - UserInfoDataSource 와 연관되어 있는 메서드

private extension UserInfoViewModel {
    /// 새로운 데이터를 저장하기 위한 메서드
    func insertData(data: UserInfoData) -> Bool {
//        guard let data = userInfo else { return false }
        let result = dataSource.insertUserInfo(data: data)
        return result
    }
    
    /// 이미 저장된 데이터를 수정하기 위해 다시 저장하는 메서드
    func updateData() -> Bool {
        guard let data = userInfo else { return false }
        
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
        dataSource.removeUserInfo(data: data)
        userInfo = nil
    }
}
