//
//  BaseRequest.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/7/24.
//

import Foundation

///  Header 에 들어가는 Token Type
enum HeaderType {
    case accessTokenHeader
    case refreshTokenHeader
    case noHeader
}

protocol BaseRequest {
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var headerType: HeaderType { get }
    var body: Data? { get }
    var queryParameter: [String: Any]? { get }
    var requestBodyParameter: Codable? { get }
}

extension BaseRequest {
    var baseURL: URL {
        guard let baseURL = URL(string: Config.baseURL) else {
            fatalError("🎄⛔️ Base URL이 존재하지 않습니다! ⛔️🎄")
        }
        return baseURL
    }
    
    var headers: [String: String]? {
        var header = [String: String]()
        
        // MARK: -TODO (KeyChain)
    
        switch headerType {
        case .accessTokenHeader:
            header["accessToken"] = ""
        case .refreshTokenHeader:
            header["refreshToken"] = ""
        case .noHeader:
            break
        }
        
        return header
    }
}
