//
//  Config.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
            static let webFrontURL = "WEB_FRONT_URL"
            static let accessTokenKey = "ACCESS_TOKEN_KEY"
            static let refreshTokenKey = "REFRESH_TOKEN_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("🎄⛔️plist cannot found !!!⛔️🎄")
        }
        return dict
    }()
}

extension Config {
    static let baseURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("🎄⛔️BASE_URL is not set in plist for this configuration⛔️🎄")
        }
        return key
    }()
    
    static let webFrontURL: String = {
        guard let key = Config.infoDictionary[Keys.Plist.webFrontURL] as? String else {
            fatalError("🎄⛔️WEB_FRONT_URL is not set in plist for this configuration⛔️🎄")
        }
        return key
    }()
    
    static let accessTokenKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.accessTokenKey] as? String else {
            fatalError("🍞⛔️ACCESS_TOKEN_KEY is not set in plist for this configuration⛔️🍞")
        }
        return key
    }()
    
    static let refreshTokenKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.refreshTokenKey] as? String else {
            fatalError("🍞⛔️REFRESH_TOKEN_KEY is not set in plist for this configuration⛔️🍞")
        }
        return key
    }()
}
