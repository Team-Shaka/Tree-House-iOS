//
//  InvitationAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

enum InvitationAPI {
    case getCheckInvitations
    case getCheckAvailableInvitation
    case postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO)
}

extension InvitationAPI: BaseRequest {
    var path: String {
        switch self {
        case .getCheckInvitations: return "users/invitation"
        case .getCheckAvailableInvitation: return "users/availableInvitation"
        case .postAcceptInvitationTreeMember: return "users/invitations/accept"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCheckInvitations: return .get
        case .getCheckAvailableInvitation: return .get
        case .postAcceptInvitationTreeMember: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getCheckInvitations, .getCheckAvailableInvitation, .postAcceptInvitationTreeMember:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postAcceptInvitationTreeMember(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
