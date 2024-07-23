//
//  AWSImageRepositoryImpl.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/18/24.
//

import Foundation
import UIKit

final class AWSImageRepositoryImpl: AWSImageRepositoryProtocol {
    private var awsService = AWSImageService()
    
    /// S3 에 이미지를 올리기 위한 API
    func putUploadImages(presignedUrls: [String], uploadImages: [UIImage]) async -> Result<[PutUploadImagesResponseEntity], NetworkError> {
        do {
            let response = try await awsService.uploadImages(presignedUrls: presignedUrls, uploadImages: uploadImages)
            var result = [PutUploadImagesResponseEntity]()
            
            response.forEach {
                result.append($0.toDomain())
            }
            
            return .success(result)
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(NetworkError.unknown)
        }
    }
}
