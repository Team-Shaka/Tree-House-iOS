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
                print($0.treeMemberName)
                print($0.bio)
            }
            print("유저 정보 불러오기: \(String(describing: data.first?.userName))")
            print("유저 정보 불러오기: \(String(describing: data.first?.bio))")

            return data.first
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeUserInfo(data: UserInfoData) {
        modelContext.delete(data)
        
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
