//
//  UploadImageToAWSUseCase.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/18/24.
//

import Foundation
import UIKit

protocol PutUploadImageToAWSUseCaseProtocol {
    func execute(presignedUrls: [String], uploadImages: [UIImage]) async -> Result<[PutUploadImagesResponseEntity], NetworkError>
}

final class UploadImageToAWSUseCase: PutUploadImageToAWSUseCaseProtocol {
    private let repository: AWSImageRepositoryProtocol
    
    init(repository: AWSImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(presignedUrls: [String], uploadImages: [UIImage]) async -> Result<[PutUploadImagesResponseEntity], NetworkError> {
        return await repository.putUploadImages(presignedUrls: presignedUrls, uploadImages: uploadImages)
    }
}
