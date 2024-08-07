//
//  TreehouseAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

enum TreehouseAPI {
    case getReadMyTreehouseInfo
    case postCreateTreehouse(requestBody: PostCreateTreehouseRequestDTO)
    case getReadTreehouseInfo(treehouseId : Int)
    case postCheckTreehouseName(requestBody: PostCheckTreehouseNameRequestDTO)
}

extension TreehouseAPI: BaseRequest {
    var path: String {
        switch self {
        case .getReadMyTreehouseInfo: return "treehouses"
        case .postCreateTreehouse: return "treehouses"
        case .getReadTreehouseInfo(let treehouseId): return "treehouses/\(treehouseId)"
        case .postCheckTreehouseName: return "treehouses/checkName"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .postCreateTreehouse, .postCheckTreehouseName: return .post
        case .getReadMyTreehouseInfo, .getReadTreehouseInfo: return .get
        }
    }
    
    var headerType: HeaderType {
        return .accessTokenHeader
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postCreateTreehouse(requestBody: let requestBody): return requestBody
        case .postCheckTreehouseName(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
