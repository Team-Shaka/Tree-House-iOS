//
//  RegisterAPI.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/2/24.
//

import Foundation

enum RegisterAPIType {
    case postCheckUserName(requestBody: PostCheckUserNameRequestDTO)
    case postRegisterUser(requestBody: PostRegisterUserRequestDTO)
    case postAcceptInvitationTreeMember(requestBody: PostAcceptInvitationTreeMemberRequestDTO)
    case postRegisterTreeMember(requestBody: PostRegisterTreeMemberRequestDTO)
    case postReissueToken(requestBody: PostReissueTokenRequestDTO)
}

extension RegisterAPIType: BaseRequest {
    var path: String {
        switch self {
        case .postCheckUserName: return "users/checkName"
        case .postRegisterUser: return "users/register"
        case .postAcceptInvitationTreeMember: return "treehouses/members/invitation/accept"
        case .postRegisterTreeMember: return "treehouses/members/register"
        case .postReissueToken: return "users/reissue"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .postCheckUserName: return .post
        case .postRegisterUser: return .post
        case .postAcceptInvitationTreeMember: return .post
        case .postRegisterTreeMember: return .post
        case .postReissueToken: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .postCheckUserName:
            return .noHeader
        case .postRegisterUser:
            return .accessTokenHeader
        case .postAcceptInvitationTreeMember:
            return .accessTokenHeader
        case .postRegisterTreeMember:
            return .accessTokenHeader
        case .postReissueToken:
            return .accessTokenHeader
        }
    }

    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }

    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postCheckUserName(requestBody: let requestBody): return requestBody
        case .postRegisterUser(requestBody: let requestBody): return requestBody
        case .postAcceptInvitationTreeMember(requestBody: let requestBody): return requestBody
        case .postRegisterTreeMember(requestBody: let requestBody): return requestBody
        case .postReissueToken(requestBody: let requestBody): return requestBody
        }
    }
}
