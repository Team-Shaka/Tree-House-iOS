//
//  InvitationAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

enum InvitationAPIType {
    case getCheckInvitations
    case getCheckAvailableInvitation
    case postWhetherInvitations(requestBody: PostWhetherInvitationsRequestDTO)
}

extension InvitationAPIType: BaseRequest {
    var path: String {
        switch self {
        case .getCheckInvitations: return "users/invitation"
        case .getCheckAvailableInvitation: return "users/availableInvitation"
        case .postWhetherInvitations: return "users/invitations/accept"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCheckInvitations: return .get
        case .getCheckAvailableInvitation: return .get
        case .postWhetherInvitations: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getCheckInvitations:
            return .accessTokenHeader
        case .getCheckAvailableInvitation:
            return .accessTokenHeader
        case .postWhetherInvitations:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postWhetherInvitations(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
