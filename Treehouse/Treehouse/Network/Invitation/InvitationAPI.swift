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
    case postWhetherInvitations(requestBody: PostWhetherInvitationsRequestDTO)
}

extension InvitationAPI: BaseRequest {
    var path: String {
        switch self {
        case .getCheckInvitations: return "users/invitation"
        case .getCheckAvailableInvitation: return "users/availableInvitation"
        case .postAcceptInvitationTreeMember: return "treehouses/members/invitation/accept"
        case .postWhetherInvitations: return "users/invitations/accept"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCheckInvitations: return .get
        case .getCheckAvailableInvitation: return .get
        case .postAcceptInvitationTreeMember: return .post
        case .postWhetherInvitations: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .getCheckInvitations:
            return .accessTokenHeader
        case .getCheckAvailableInvitation:
            return .accessTokenHeader
        case .postAcceptInvitationTreeMember:
            return .accessTokenHeader
        case .postWhetherInvitations:
            return .accessTokenHeader
        }
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postAcceptInvitationTreeMember(requestBody: let requestBody): return requestBody
        case .postWhetherInvitations(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
