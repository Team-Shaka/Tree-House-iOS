//
//  PhoneNumberViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/11/24.
//

import Foundation
import Observation
import Contacts

enum ContactError: Error, LocalizedError {
    case inaccessible
    case noData
    
    var errorDescription: String? {
        switch self {
        case .inaccessible:
            return "📱 연락처에 접근할 수 없습니다."
        case .noData:
            return "☎️ 연락처에 저장된 전화번호가 없습니다."
        }
    }
}

@Observable
final class PhoneNumberViewModel {
    
    // MARK: - ObservationIgnored Property
    
    @ObservationIgnored
    var phoneNumberList = [UserPhoneNumberInfo]()
    
    // MARK: - Observation Property
    
    var errorMessage: String?
    var searchText: String = ""
    var searchPhoneNumberList = [UserPhoneNumberInfo]()
    
    // MARK: - init
    
    init() {
        Task {
            do {
                try await requsetAccessLocalStore()
            } catch {
                errorHandler(error: error)
            }
        }
    }
    
    /// 오류 분기처리해주는 메서드
    private func errorHandler(error: Error) {
        if let contactError = error as? ContactError {
            self.errorMessage = contactError.errorDescription
        } else {
            self.errorMessage = error.localizedDescription
        }
    }
    
    /// 이름 또는 전화번호로 초대할 유저를 검색하는 메서드
    func searchData() async {
        if searchText.isEmpty {
            searchPhoneNumberList = phoneNumberList
        } else {
            searchPhoneNumberList = phoneNumberList.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.phoneNumber.split(separator: "-").joined().contains(searchText)
            }
        }
    }
}

// MARK: - Contacts Extension

extension PhoneNumberViewModel {
    /// CNContactStore 에 접근이 가능한지 체크하는 메서드
    func requsetAccessLocalStore() async throws {
        let store = CNContactStore()
        
        do {
            let isAccess = try await store.requestAccess(for: .contacts)
            if isAccess {
                try await self.loadUserInfoData(from: store)
            }
        } catch {
            throw ContactError.inaccessible
        }
    }
    
    /// CNContactStore 에 접근이 가능할때 연락처에 있는 유저 정보를 불러오는 메서드
    func loadUserInfoData(from store: CNContactStore) async throws {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        var contacts: [UserPhoneNumberInfo] = []
        
        let result = try await withCheckedThrowingContinuation { continuation in
            do {
                try store.enumerateContacts(with: request) { contact, stop in
                    let name = "\(contact.familyName)\(contact.givenName)"
                    let profileImage = contact.imageData
                    for phoneNumber in contact.phoneNumbers {
                        let number = phoneNumber.value.stringValue

                        contacts.append(UserPhoneNumberInfo(name: name, phoneNumber: number.formatPhoneNumber, profileImage: profileImage, isInvitation: false))
                    }
                }
                continuation.resume(returning: contacts)
            } catch {
                continuation.resume(throwing: error)
            }
        }
        
        await MainActor.run {
            self.phoneNumberList = result
            self.searchPhoneNumberList = result
        }
    }
}
