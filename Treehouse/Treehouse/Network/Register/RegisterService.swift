//
//  RegisterService.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/2/24.
//
//

import Foundation

class RegisterService {
    
    private let networkServiceManager = NetworkServiceManager()
    
    /// 유저 아이디 중복 확인 요청 API
    func postCheckName(userName: String) async throws -> PostCheckUserNameResponseDTO {
        
        let request = NetworkRequest(requestType: RegisterAPI.postCheckUserName(requestBody: PostCheckUserNameRequestDTO(userName: userName)))
       
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCheckUserNameResponseDTO.self)
    }
    
    /// 토큰 재발급 요청 API
    func postReissueToken() async throws -> PostReissueTokenResponseDTO {
        
        // RefreshToken 이 저장되어있는지 확인
        guard let loadRefreshToken = KeychainHelper.shared.load(for: Config.refreshTokenKey) else {
            throw NetworkError.clientError(message: "토큰 없음")
        }
        
        let request = NetworkRequest(requestType: RegisterAPI.postReissueToken(requestBody: PostReissueTokenRequestDTO(refreshToken: loadRefreshToken)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "토큰 없음")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostReissueTokenResponseDTO.self)
    }
    
    /// 신규 유저 회원가입 요청 API
    func postRegisterUser(phoneNumber: String, userName: String) async throws -> PostRegisterUserResponseDTO {
        
        let request = NetworkRequest(requestType: RegisterAPI.postRegisterUser(requestBody: PostRegisterUserRequestDTO(phoneNumber: phoneNumber, userName: userName)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostRegisterUserResponseDTO.self)
    }

    /// 트리하우스 멤버 가입 API
    func postRegisterTreeMember(requestBody: PostRegisterTreeMemberRequestDTO) async throws -> PostRegisterTreeMemberResponseDTO {
        
        let request = NetworkRequest(requestType: RegisterAPI.postRegisterTreeMember(requestBody: requestBody))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostRegisterTreeMemberResponseDTO.self)
    }
    
    /// 이전에 회원가입이 되어있는지 전화번호 인증 API
    func postCheckUserPhone(phoneNumber: String) async throws -> PostCheckUserPhoneResponseDTO {
        
        let request = NetworkRequest(requestType: RegisterAPI.postCheckUserPhone(requestBody: PostCheckUserPhoneRequestDTO(phoneNumber: phoneNumber)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostCheckUserPhoneResponseDTO.self)
    }
    
    /// 이미 가입한 유저가 다시 로그인하기 위한 API
    func postExistsUserLogin(phoneNumber: String) async throws -> PostExistsUserLoginResponseDTO {
        
        let request = NetworkRequest(requestType: RegisterAPI.postExistsUserLogin(requestBody: PostExistsUserLoginRequestDTO(phoneNumber: phoneNumber)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: PostExistsUserLoginResponseDTO.self)
    }
    
    /// 회원탈퇴를 위한 API
    func deleteUser() async throws -> DeleteUserResponseDTO {
        let request = NetworkRequest(requestType: RegisterAPI.deleteUser)
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        return try await networkServiceManager.performRequest(with: urlRequest, decodingType: DeleteUserResponseDTO.self)
    }
}
