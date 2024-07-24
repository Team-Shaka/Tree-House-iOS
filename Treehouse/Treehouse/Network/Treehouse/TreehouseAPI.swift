//
//  TreehouseAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/24/24.
//

import Foundation

enum TreehouseAPI {
    case postCreateTreehouses(requestBody: PostCreateTreehousesRequestDTO)
    case getReadTreehousesInfo(treehouseId : Int)
}

extension TreehouseAPI: BaseRequest {
    var path: String {
        switch self {
        case .postCreateTreehouses: return "treehouses"
        case .getReadTreehousesInfo(let treehouseId): return "treehouses/\(treehouseId)"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .postCreateTreehouses: return .post
        case .getReadTreehousesInfo: return .get
        }
    }
    
    var headerType: HeaderType {
        return .accessTokenHeader
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postCreateTreehouses(requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
