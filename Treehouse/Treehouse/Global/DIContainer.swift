//
//  DIContainer.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/4/24.
//

import Foundation

final class DIContainer {
    static let shared = DIContainer()
        
    private init() {}
    
    // ViewModel을 저장할 딕셔너리
    private var viewModels: [String: Any] = [:] {
        didSet {
            print(viewModels)
        }
    }
    
    // ViewModel 반환 메서드
    func getViewModel<T>(for key: String, createIfNeeded: () -> T) -> T {
        if let viewModel = viewModels[key] as? T {
            return viewModel
        } else {
            let viewModel = createIfNeeded()
            viewModels[key] = viewModel
            return viewModel
        }
    }
}
