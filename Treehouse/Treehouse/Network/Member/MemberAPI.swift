//
//  MemberAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

enum MemberAPI {
    case getReadMemberInfo(treehouseId: Int, memberId: Int)
    case getReadMemberFeed(treehouseId: Int, memberId: Int)
    case getReadMyProfileInfo(treehouseId: Int)
    case patchModifyMyProfile(treehouseId: Int, requestBody: PatchModifyMyProfileRequestDTO)
}

extension MemberAPI: BaseRequest {
    var path: String {
        switch self {
        case .getReadMemberInfo(let treehouseId, let memberId):
            return "treehouses/\(treehouseId)/profiles/\(memberId)"
        case .getReadMemberFeed(let treehouseId, let memberId):
            return "treehouses/\(treehouseId)/profiles/\(memberId)/posts"
        case .getReadMyProfileInfo(let treehouseId):
            return "treehouses/\(treehouseId)/profiles/myProfile"
        case .patchModifyMyProfile(let treehouseId, _):
            return "treehouses/\(treehouseId)/profiles/myProfile"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getReadMemberInfo, .getReadMemberFeed, .getReadMyProfileInfo: return .get
        case .patchModifyMyProfile: return .patch
        }
    }
    
    var headerType: HeaderType {
        return .accessTokenHeader
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .patchModifyMyProfile(_ , requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
