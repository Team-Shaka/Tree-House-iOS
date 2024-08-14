//
//  NotificationAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

enum NotificationAPI {
    case getReadNotifications
    case postCheckNotifications(notificationId: Int)
}

extension NotificationAPI: BaseRequest {
    var path: String {
        switch self {
        case .getReadNotifications: return "users/notifications"
        case .postCheckNotifications(let notificationId): return "users/notifications/\(notificationId)"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getReadNotifications: return .get
        case .postCheckNotifications: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getReadNotifications, .postCheckNotifications:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? { return .none }
}
