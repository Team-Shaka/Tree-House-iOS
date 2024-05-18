//
//  NetworkServiceable.swift
//  Treehouse
//
//  Created by 윤영서 on 5/14/24.
//

import Foundation

protocol NetworkServiceable {
    func performRequest<T: Decodable>(with request: URLRequest, decodingType: T.Type) async throws -> T
    func handleError(data: Data?, response: URLResponse?) throws -> NetworkError?
}

extension NetworkServiceable {
    func performRequest<T: Decodable>(with request: URLRequest, decodingType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        if let error = try handleError(data: data, response: response) {
            throw error
        }

        do {
            let model = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            return model.data
        } catch {
            throw NetworkError.jsonDecodingError
        }
    }

    func handleError(data: Data?, response: URLResponse?) throws -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.serverError
        }
        
        guard httpResponse.statusCode == 200 else {
            return try parseErrorResponse(data: data, statusCode: httpResponse.statusCode)
        }
        
        return nil
    }

    private func parseErrorResponse(data: Data?, statusCode: Int) throws -> NetworkError? {
        guard let jsonData = data,
              let decoded = try? JSONDecoder().decode(BaseResponse<String>.self, from: jsonData) else {

            throw NetworkError.jsonDecodingError
        }

        let code = decoded.code
        let message = decoded.message
        
        switch statusCode {
        case 400...499:
            if NetworkErrorCode.globalValidationError.contains(code) {
                throw NetworkError.clientError(message: message)
            }
            
            if NetworkErrorCode.validateNumberError.contains(code) {
                throw NetworkError.clientError(message: message)
            }
            
            if NetworkErrorCode.registerError.contains(code) {
                throw NetworkError.clientError(message: message)
            }
            
        case 500...599:
            throw NetworkError.serverError
            
        default:
            throw NetworkError.unknown
        }

        return nil
    }
}
