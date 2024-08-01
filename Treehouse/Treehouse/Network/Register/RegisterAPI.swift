//
//  RegisterAPI.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/2/24.
//

import Foundation

enum RegisterAPI {
    case postCheckUserName(requestBody: PostCheckUserNameRequestDTO)
    case postRegisterUser(requestBody: PostRegisterUserRequestDTO)
    case postRegisterTreeMember(requestBody: PostRegisterTreeMemberRequestDTO)
    case postReissueToken(requestBody: PostReissueTokenRequestDTO)
    case postCheckUserPhone(requestBody: PostCheckUserPhoneRequestDTO)
    case postExistsUserLogin(requestBody: PostExistsUserLoginRequestDTO)
}

extension RegisterAPI: BaseRequest {
    var path: String {
        switch self {
        case .postCheckUserName: return "users/checkName"
        case .postRegisterUser: return "users/register"
        case .postRegisterTreeMember: return "members/register"
        case .postReissueToken: return "users/reissue"
        case .postCheckUserPhone: return "users/phone"
        case .postExistsUserLogin: return "users/login"
        }
    }

    var httpMethod: HttpMethod {
        switch self {
        case .postCheckUserName: return .post
        case .postRegisterUser: return .post
        case .postRegisterTreeMember: return .post
        case .postReissueToken: return .post
        case .postCheckUserPhone: return .post
        case .postExistsUserLogin: return .post
        }
    }
    
    var headerType: HeaderType {
        switch self {
        case .postCheckUserName, .postRegisterUser, .postCheckUserPhone:
            return .noHeader
        case .postRegisterTreeMember:
            return .accessTokenHeader
        case .postReissueToken:
            return .refreshTokenHeader
        default:
            return .noHeader
        }
    }

    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }

    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postCheckUserName(requestBody: let requestBody): return requestBody
        case .postRegisterUser(requestBody: let requestBody): return requestBody
        case .postRegisterTreeMember(requestBody: let requestBody): return requestBody
        case .postReissueToken(requestBody: let requestBody): return requestBody
        case .postCheckUserPhone(requestBody: let requestBody): return requestBody
        case .postExistsUserLogin(requestBody: let requestBody): return requestBody
        }
    }
}
