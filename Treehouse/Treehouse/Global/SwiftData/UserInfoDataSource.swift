//
//  UserInfoDataSource.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/27/24.
//

import SwiftData

final class UserInfoDataSource {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = UserInfoDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: UserInfoData.self)
        self.modelContext = modelContainer.mainContext
    }
    
    func insertUserInfo(data: UserInfoData) -> Bool {
        modelContext.insert(data)
        return true
    }
    
    func saveUserInfo() -> Result<Bool, Error> {
        do {
            try modelContext.save()
            return .success(true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchItem() -> UserInfoData? {
        do {
            let data = try modelContext.fetch(FetchDescriptor<UserInfoData>())
            
            data.forEach {
                print($0.userName)
            }
            print("유저 이름: \(String(describing: data.first?.userName))")
            print("유저 프로필: \(String(describing: data.first?.profileImageUrl))")
            print("가입한 Treehouse: \(String(describing: data.first?.treehouses))")
            
            data.first?.treehouseInfo.forEach {
                print("첫번째 Treehouse ID: \(String(describing: $0.treehouseId))")
                print("첫번째 Treehouse Name: \(String(describing: $0.treehouseName))")
                print("첫번째 Treehouse Member ID: \(String(describing: $0.treehouseMemberId))")
            }
    
            return data.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeUserInfo(data: UserInfoData) {
        modelContext.delete(data)
        
        do {
            try modelContext.save()
            print("유저 정보 삭제 성공")
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
