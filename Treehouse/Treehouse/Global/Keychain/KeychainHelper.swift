//
//  KeychainHelper.swift
//  Treehouse
//
//  Created by 윤영서 on 5/17/24.
//

import Foundation
import Security

class KeychainHelper {
    
    static let shared = KeychainHelper()
    private init() {}
    
    /// 데이터를 Keychain에 저장
    func save(_ value: String, for key: String) {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            switch status {
            case errSecSuccess:
                print("✅ 키: \(key) 에 대한 아이템 저장에 성공했습니다.")
                
            case errSecDuplicateItem:
                print("⚠️ 키: \(key) 에 대한 아이템이 이미 존재합니다.")
                // 이미 존재하는 경우, 기존 아이템을 업데이트
                let updateStatus = update(value, for: key)
                print(updateStatus ? "✅ 키: \(key) 에 대한 아이템 업데이트에 성공했습니다." : "❌ 키: \(key) 에 대한 아이템 업데이트에 실패했습니다.")
                
            default:
                print("❌ 키: \(key) 에 대한 아이템 저장에 실패했습니다. 상태: \(status)")
            }
        }
    }
    
    /// Keychain에서 데이터를 불러옴
    func load(for key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        switch status {
        case errSecSuccess:
            print("✅ 키: \(key) 에 대한 아이템 불러오기에 성공했습니다.")
            if let data = dataTypeRef as? Data,
               let result = String(data: data, encoding: .utf8) {
                return result
            }
            
        case errSecItemNotFound:
            print("⚠️ 키: \(key) 에 대한 아이템을 찾을 수 없습니다.")
            
        default:
            print("❌ 키: \(key) 에 대한 아이템 불러오기에 실패했습니다. 상태: \(status)")
        }
        return nil
    }
    
    /// Keychain에서 데이터를 삭제
    func delete(for key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        switch status {
        case errSecSuccess:
            print("✅ 키: \(key) 에 대한 아이템 삭제에 성공했습니다.")
            
        case errSecItemNotFound:
            print("⚠️ 키: \(key) 에 대한 삭제할 아이템을 찾을 수 없습니다.")
            
        default:
            print("❌ 키: \(key) 에 대한 아이템 삭제에 실패했습니다. 상태: \(status)")
        }
    }
    
    /// Keychain에 있는 기존 데이터를 업데이트
    private func update(_ value: String, for key: String) -> Bool {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key
            ]
            
            let attributes: [String: Any] = [
                kSecValueData as String: data
            ]
            
            let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
            return status == errSecSuccess
        }
        return false
    }
}
