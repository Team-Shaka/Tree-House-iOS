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
    case postInvitation(requestBody: PostInvitationRequestDTO)
    case postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO)
}

extension InvitationAPI: BaseRequest {
    var path: String {
        switch self {
        case .getCheckInvitations: return "users/invitation"
        case .getCheckAvailableInvitation: return "users/availableInvitation"
        case .postInvitation: return "users/invitation"
        case .postAcceptInvitationTreeMember: return "users/invitations/accept"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCheckInvitations, .getCheckAvailableInvitation: return .get
        case .postInvitation, .postAcceptInvitationTreeMember: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getCheckInvitations, .getCheckAvailableInvitation, .postInvitation, .postAcceptInvitationTreeMember:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postInvitation(requestBody: let requestBody): return requestBody
        case .postAcceptInvitationTreeMember(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
