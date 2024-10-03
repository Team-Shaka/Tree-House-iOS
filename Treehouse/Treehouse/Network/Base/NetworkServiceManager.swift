//
//  NetworkServiceManager.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/3/24.
//

import Foundation
typealias EmptyResponse = BaseResponse<Empty>

final class NetworkServiceManager: NetworkServiceable {
    private var originalRequest: URLRequest?
//    private var isReissueToken: Bool = false

    /// 통신을 위한 Request 를 전달받고 호출하는 메서드
    /// - Parameters:
    ///     - request : URLSession 에서 요청을 보내기 위해 Service 에서 생성한 URLRequest
    ///     - decodingType : URLSession 요청으로 받은 응답을 디코딩하는 데 사용되는 제네릭 (DTO)
    func performRequest<T>(with request: URLRequest, decodingType: T.Type) async throws -> T where T: Decodable {
        
        self.originalRequest = request
        let apiName = removeResponseDTO("\(decodingType)")
        
        print("1️⃣ \(apiName) API 호출 ========================================")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        do {
            if let result = try await requestResultHandeler(data: data, response: response, decodingType: decodingType) {
                print("4️⃣ \(apiName) API 종료 ========================================")
                return result
            } else {
                print("4️⃣ \(apiName) API 종료 ========================================")
                return Empty() as! T
            }
        } catch {
            throw error
        }
    }
    
    /// URLSession 에서 요청을 보낸 후 반환값에 대한 결과를 분기처리하기 위한 메서드
    /// - Parameters:
    ///     - data : URLSession 요청으로 인한 반환 데이터를 전달받는 변수
    ///     - response : URLSession 요청으로 인한 메타 데이터를 전달받는 변수
    ///     - decodingType : URLSession 요청으로 인한 반환 데이터를 알맞는 구조체로 디코딩하기 위한 타입을 전달받는 변수
    /// - Returns : decodingType 에 맞춰 디코딩한 결과를 반환
    /// - Throws : NetworkError 에 의거, URLSession 의 반환 결과에 대한 오류나 디코딩 오류를 반환
    func requestResultHandeler<T>(data: Data, response: URLResponse?, decodingType: T.Type) async throws -> T? where T: Decodable {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError
        }
        print("2️⃣ Status Code: \(httpResponse.statusCode)")
        
        do {
            let decodingData = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            print(decodingData.data)
            switch httpResponse.statusCode {

            case 200:
                print("3️⃣ Response JSON")
                if let responseData = decodingData.data {
                    print(responseData)
                    return responseData
                } else {
                    print("데이터 없음")
                    return nil
                }
                
            case 400:
                if NetworkErrorCode.globalValidationError.contains(decodingData.code) {
                    throw NetworkError.clientError(message: decodingData.message )
                }
                
                if NetworkErrorCode.registerError.contains(decodingData.code) {
                    throw NetworkError.clientError(message: decodingData.message )
                }
                
                if NetworkErrorCode.validateNumberError.contains(decodingData.code) {
                    throw NetworkError.clientError(message: decodingData.message)
                }
                
                if NetworkErrorCode.invitationError.contains(decodingData.code) {
                    throw NetworkError.clientError(message: decodingData.message)
                }
                
                throw NetworkError.clientError(message: "Unknown 400 error")
                
            case 401...408:
                try await postReissueToken()
                
                // KeyChain 으로 저장한 accessToken 이 존재하는지?
                guard let accessToken = KeychainHelper.shared.load(for: Config.accessTokenKey) else { throw NetworkError.unknown }
                
                // 기존의 URLRequest 의 header 에 새로운 AccessToken 으로 변경
                guard var originalRequest = originalRequest else { throw NetworkError.clientError(message: "저장된 토큰이 없습니다.") }
                originalRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
                
                // 기존의 URLRequest 를 통해 URLSession 요청
                let (data, _) = try await URLSession.shared.data(for: originalRequest)
                
                let model = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
                if let responseData = model.data {
                    return responseData
                } else {
                    throw NetworkError.jsonDecodingError
                }
                
            case 409:
                throw NetworkError.duplicationError
                
            case 500...599:
                throw NetworkError.serverError
                
            default:
                throw NetworkError.unknown
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }
}

extension NetworkServiceManager {
    
    /// API 이름을 출력하기 위한 메서드
    func removeResponseDTO(_ string: String) -> String {
        return string.replacingOccurrences(of: "ResponseDTO", with: "")
    }
    
    /// 토큰 재발급 API
    func postReissueToken() async throws {
        print("1️⃣ PostReissueToken API 호출 ========================================")
        
        // RefreshToken 이 저장되어있는지 확인
        guard let loadRefreshToken = KeychainHelper.shared.load(for: Config.refreshTokenKey) else {
            UserDefaults.standard.set(false, forKey: Config.loginKey)
            throw NetworkError.clientError(message: "저장된 토큰이 없습니다.")
        }
        
        let request = NetworkRequest(requestType: RegisterAPI.postReissueToken(requestBody: PostReissueTokenRequestDTO(refreshToken: loadRefreshToken)))
        
        guard let urlRequest = request.request() else {
            throw NetworkError.clientError(message: "다시 시도해주세요.")
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 응답 데이터와 상태 코드 출력
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError
        }
        
        print("2️⃣ Status Code: \(httpResponse.statusCode)")
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("3️⃣ Response JSON: \(jsonString)")
        }
        
        // JSON 디코딩
        do {
            switch httpResponse.statusCode {
            case 200:
                let model = try JSONDecoder().decode(BaseResponse<PostReissueTokenResponseDTO>.self, from: data)
                
                guard let newToken = model.data else { throw NetworkError.reIssueJWT }
                
                // KeyChain 을 통해 AccessToken, RefreshToken 갱신
                KeychainHelper.shared.save(newToken.accessToken, for: Config.accessTokenKey)
                KeychainHelper.shared.save(newToken.refreshToken, for: Config.refreshTokenKey)
                print("4️⃣ PostReissueToken API 종료 ========================================")
            case 401:
                UserDefaults.standard.set(false, forKey: Config.loginKey)
                
                /// RefreshToken 도 만료되었을 때 다시
                throw NetworkError.clientError(message: "로그인이 만료되었습니다. 다시 로그인해주세요.")
            default:
                UserDefaults.standard.set(false, forKey: Config.loginKey)
                throw NetworkError.serverError
            }
        } catch (let error){
            print("4️⃣ PostReissueToken API Error: \(String(describing: error))========================================")
            throw NetworkError.reIssueJWT
        }
    }
}
