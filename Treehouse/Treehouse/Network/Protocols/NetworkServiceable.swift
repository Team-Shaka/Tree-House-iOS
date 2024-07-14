//
//  NetworkServiceable.swift
//  Treehouse
//
//  Created by 윤영서 on 5/14/24.
//

import Foundation

protocol NetworkServiceable {
    func performRequest<T: Decodable>(with request: URLRequest, decodingType: T.Type) async throws -> T
    func requestResultHandeler<T: Decodable>(data: Data, response: URLResponse?, decodingType: T.Type) async throws -> T? where T: Decodable
}
