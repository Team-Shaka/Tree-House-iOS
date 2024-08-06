//
//  PresingedURLViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/31/24.
//

import Foundation
import Observation
import UIKit

final class PresingedURLViewModel: BaseViewModel {
    
    @ObservationIgnored
    private let presignedURLUseCase: PostPresignedURLUseCaseProtocol
    
    init(presignedURLUseCase: PostPresignedURLUseCaseProtocol) {
        self.presignedURLUseCase = presignedURLUseCase
    }
    
    func presignedURL(treehouseId: Int, memberId: Int, selectImage: [UIImage]) async -> [PresignedURLResponseEntity]? {
        
        var result = [PresignedURLResponseEntity?](repeating: nil, count:
                                                        selectImage.count)
        
        await withTaskGroup(of: (Int, PresignedURLResponseEntity?).self) { group in
            for (index, image) in selectImage.enumerated() {
                group.addTask {
                    let result = await self.presignedURLUseCase.execute(treehouseId: treehouseId, fileName: "\(memberId)_PostImage", fileSize: image.getImageBitSize())
                    
                    switch result {
                    case .success(let response):
                        return (index, PresignedURLResponseEntity(presignedUrl: response.presignedUrl, accessUrl: response.accessUrl))

                    case .failure(_):
                        return (index, nil)
                    }
                }
            }
            
            for await resultData in group {
                if let data = resultData.1 {
                    result[resultData.0] = PresignedURLResponseEntity(presignedUrl: data.presignedUrl, accessUrl: data.accessUrl)
                }
            }
        }
        
        if result.contains(where: { $0 == nil} ) {
            return nil
        } else {
            return result.compactMap { $0 }
        }
    }
}
