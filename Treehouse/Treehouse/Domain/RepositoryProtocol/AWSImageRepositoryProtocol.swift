//
//  AWSImageRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/18/24.
//

import Foundation
import UIKit

protocol AWSImageRepositoryProtocol {
    func putUploadImages(presignedUrls: [String], uploadImages: [UIImage]) async -> Result<[PutUploadImagesResponseEntity],NetworkError>
//    func putUploadImages() async -> Result<Bool,NetworkError>
}
