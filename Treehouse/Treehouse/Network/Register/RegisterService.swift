//
//  RegisterService.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/2/24.
//
//

import Foundation

class RegisterService: NetworkServiceable {
    
    /// 유저 아이디 중복 확인 요청
    func postCheckName(userName: String) async throws -> PostCheckUserNameResponseDTO {
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
            print("Status Code: \(httpResponse.statusCode)")
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON: \(jsonString)")
        }
        
        // JSON 디코딩
        do {
            let model = try JSONDecoder().decode(BaseResponse<PostCheckUserNameResponseDTO>.self, from: data)
            return model.data
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }
}
