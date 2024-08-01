//
//  LoadImageAWSViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import Foundation
import Observation
import UIKit

@Observable
final class LoadImageAWSViewModel: BaseViewModel {
    
    var isloadImageAWS = [Bool]()
    var failureIndex: Int?
    var errorMessage = ""
    
    // MARK: - UseCase Property
    
    @ObservationIgnored
    private let uploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol
    
    // MARK: - init
    
    init(uploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol) {
        self.uploadImageToAWSUseCase = uploadImageToAWSUseCase
    }
    
    deinit {
        print("Deinit LoadImageAWSViewModel")
    }
}

// MARK: - API Extension

extension LoadImageAWSViewModel {
    func loadImageAWS(uploadImages: [UIImage], ImageUrl: [PresignedURLResponseEntity]) async -> Bool {
        
        let presignedUrls = ImageUrl.map { $0.presignedUrl }
        
        let result = await uploadImageToAWSUseCase.execute(presignedUrls: presignedUrls, uploadImages: uploadImages)

        switch result {
        case .success(let response):
            response.forEach { data in
                if data.result == false {
                    failureIndex = data.index
                }
            }
            
            if let data = failureIndex {
                print("업로드 실패한 이미지 다시 올리기")
                let result = await uploadImageToAWSUseCase.execute(presignedUrl: presignedUrls[data], uploadImage: uploadImages[data])
                
                switch result {
                case .success(let response):
                    return response
                    
                case .failure:
                    return false
                }
            } else {
                return true
            }
            
        case .failure(let error):
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
            
            isloadImageAWS.append(false)
            return false
        }
    }
}
