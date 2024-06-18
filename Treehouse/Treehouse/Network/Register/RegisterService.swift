//
//  RegisterService.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/2/24.
//
//

import Foundation

class RegisterService: NetworkServiceable {
    
    /// 유저 아이디 중복 확인 요청 API
    func postCheckName(userName: String) async throws -> PostCheckUserNameResponseDTO {
        
        print("1️⃣ PostCheckName API 호출 ========================================")
        print("Input - userName: \(userName)")
        
        // 요청 DTO 생성
        let requestDTO = PostCheckUserNameRequestDTO(userName: userName)
        
        // RegisterAPI enum을 사용해 URLRequest 생성
        var request = URLRequest(url: RegisterAPI.postCheckUserName(requestBody: requestDTO).baseURL.appendingPathComponent(RegisterAPI.postCheckUserName(requestBody: requestDTO).path))
        request.httpMethod = RegisterAPI.postCheckUserName(requestBody: requestDTO).httpMethod.rawValue
        request.allHTTPHeaderFields = RegisterAPI.postCheckUserName(requestBody: requestDTO).headers
        
        // RequestBody를 JSON 형식으로 변환
        request.httpBody = try JSONEncoder().encode(requestDTO)
        
        // performRequest 메서드를 사용해 네트워크 요청 수행
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostCheckUserNameResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostCheckName API 종료 ========================================")
            return model.data
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 토큰 재발급 요청 API
    func postReissueToken() async throws -> PostReissueTokenResponseDTO {
        
        print("1️⃣ PostReissueToken API 호출 ========================================")
        
        // RefreshToken 이 저장되어있는지 확인
        guard let loadRefreshToken = KeychainHelper.shared.load(for: Config.refreshTokenKey) else {
            throw NetworkError.clientError(message: "토큰 없음")
        }
        
        let request = NetworkRequest(requestType: RegisterAPI.postReissueToken(requestBody: PostReissueTokenRequestDTO(refreshToken: loadRefreshToken)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "토큰 없음")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
            print("\(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostReissueTokenResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostReissueToken API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostReissueToken API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 신규 유저 회원가입 요청 API
    func postRegisterUser(phoneNumber: String, userName: String) async throws -> PostRegisterUserResponseDTO {
        
        print("1️⃣ PostRegisterUser API 호출 ========================================")
        print("Input - phoneNumber: \(phoneNumber), userName: \(userName)")
        
        let request = NetworkRequest(requestType: RegisterAPI.postRegisterUser(requestBody: PostRegisterUserRequestDTO(phoneNumber: phoneNumber, userName: userName)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
            print("\(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostRegisterUserResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostRegisterUser API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostRegisterUser API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }

    /// 트리하우스 멤버 가입 API
    func postRegisterTreeMember(requestBody: PostRegisterTreeMemberRequestDTO) async throws -> PostRegisterTreeMemberResponseDTO {
        
        print("1️⃣ PostRegisterTreeMember API 호출 ========================================")
        print("Input - PostRegisterTreeMemberRequestDTO: \(requestBody)")
        let request = NetworkRequest(requestType: RegisterAPI.postRegisterTreeMember(requestBody: requestBody))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
            print(jsonString)
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostRegisterTreeMemberResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostRegisterTreeMember API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostRegisterTreeMember API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
    
    /// 이전에 회원가입이 되어있는지 전화번호 인증 API
    func postCheckUserPhone(phoneNumber: String) async throws -> PostCheckUserPhoneResponseDTO {
        print("1️⃣ PostRegisterTreeMember API 호출 ========================================")
        
        let request = NetworkRequest(requestType: RegisterAPI.postCheckUserPhone(requestBody: PostCheckUserPhoneRequestDTO(phoneNumber: phoneNumber)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "Request 생성불가")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        if let httpResponse = response as? HTTPURLResponse {
            print("2️⃣ Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostCheckUserPhoneResponseDTO>.self, from: data)
            print(model.data)
            print("4️⃣ PostRegisterTreeMember API 종료 ========================================")
            return model.data
        } catch {
            print("4️⃣ PostRegisterTreeMember API Error: \(String(describing: NetworkError.jsonDecodingError.errorDescription))========================================")
            throw NetworkError.jsonDecodingError
        }
    }
}
