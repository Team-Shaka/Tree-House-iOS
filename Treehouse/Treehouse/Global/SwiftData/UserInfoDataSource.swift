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
    
    func saveUserInfo(data: UserInfoData) -> Result<Bool, Error> {
        modelContext.insert(data)
        
        do {
            try modelContext.save()
            return .success(true)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchItem() -> UserInfoData? {
        do {
            let items = try modelContext.fetch(FetchDescriptor<UserInfoData>())
            return items.first
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
