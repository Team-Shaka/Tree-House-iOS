//
//  NetworkError.swift
//  Treehouse
//
//  Created by 윤영서 on 5/13/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case urlEncodingError
    case jsonDecodingError
    case fetchImageError
    case clientError(message: String)
    case serverError
    case unAuthorizedError
    case userState(code: String, message: String)
    case reIssueJWT
    case unknown
    case duplicationError
    
    var errorDescription: String? {
        switch self {
        case .urlEncodingError:
            return "🛠️ URL Encoding 에러입니다 🛠️"
        case .jsonDecodingError:
            return "⚙️ JSON Decoding 에러입니다 ⚙️"
        case .fetchImageError:
            return "🔗 Image URL로부터 불러오기 실패했습니다 🔗"
        case .clientError(let message):
            return message
        case .serverError:
            return "🔩 서버 에러입니다 🔩"
        case .userState(let code, let message):
            return message
        case .unAuthorizedError:
            return "⛏️ 접근 권한이 없습니다 (토큰 만료) ⛏️"
        case .reIssueJWT:
            return "🔧 JWT토큰을 재발급해야 합니다 🔧"
        case .unknown:
            return "📁 알 수 없는 에러입니다. 📁"
        case .duplicationError:
            return "📝 중복된 유저나 전화번호 입니다. 📝"
        }
    }
}
