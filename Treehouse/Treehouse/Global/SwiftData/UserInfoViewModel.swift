//
//  UserInfoViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/27/24.
//

import Observation

final class UserInfoViewModel {
    
    @ObservationIgnored
    private let dataSource: UserInfoDataSource

    private var userInfo: UserInfoData?

    init(dataSource: UserInfoDataSource = UserInfoDataSource.shared) {
        self.dataSource = dataSource
        self.userInfo = dataSource.fetchItem()
    }
    
    /// UserInfoData 를 처음으로 만들기 위한 메서드
    func createData(newData: UserInfoData) -> Bool {
        userInfo = newData
        return saveData()
    }

    /// treememberName 을 수정하기 위한 메서드
    func modifyMemberName(memberName: String) -> Bool {
        userInfo?.treeMemberName = memberName
        return saveData()
    }

    /// bio 를 수정하기 위한 메서드
    func modifyBio(bio: String) -> Bool {
        userInfo?.bio = bio
        return saveData()
    }
}

// MARK: - UserInfoDataSource 와 연관되어 있는 메서드

private extension UserInfoViewModel {
    func saveData() -> Bool {
        guard let data = userInfo else { return false }
        
        switch dataSource.saveUserInfo(data: data) {
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
