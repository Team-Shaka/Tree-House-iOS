//
//  NetworkRequest.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/3/24.
//

import Foundation

struct NetworkRequest<T: BaseRequest> {
    let requestType: T

    init(requestType: T) {
        self.requestType = requestType
    }

    func request() -> URLRequest? {

        /// URL 이 잘 구성되어 있는지
        guard let url = URL(string: Config.baseURL + requestType.path) else {
            return nil
        }

        /// url 을 할당하여 URLRequest 생성 및  HTTP 방식 설정
        var request = URLRequest(url: url)
        request.httpMethod = requestType.httpMethod.rawValue

        /// header 가 설정되어 있다면 request 에 key 와 value 를 통해 Dictional 설정
        if let headers = requestType.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        // body 가 존재하면 설정
        if let body = requestType.body {
            request.httpBody = body
        } else if let requestBody = requestType.requestBodyParameter {
            do {
                request.httpBody = try JSONEncoder().encode(requestBody)
            } catch {
                print("Error encoding request body: \(error)")
            }
        }

        // parameters 가 존재하면 설정
        if let queryParameters = requestType.queryParameter {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            request.url = components.url
        }

        return request
    }
}
