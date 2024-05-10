//
//  NotificationAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

enum NotificationAPI {
    case getCheckNotifications
}

extension NotificationAPI: BaseRequest {
    var path: String {
        switch self {
        case .getCheckNotifications: return "users/notifiactions?page="
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCheckNotifications: return .get
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getCheckNotifications:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? { return .none }
}
