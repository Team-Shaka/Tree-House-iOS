//
//  AWSImageService.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/18/24.
//

import Foundation
import UIKit

final class AWSImageService {
    
    /// AWS S3에 이미지 업로드
    func uploadImage(presignedUrl: String, uploadImage: UIImage) async throws -> Bool {
        print("1️⃣ uploadImage API 호출 ========================================")
        
        guard let url = URL(string: presignedUrl) else {
            print("URL 변환 실패")
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("image/png", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = uploadImage.pngData() else {
            throw NetworkError.clientError(message: "이미지 데이터를 변환하는 데 실패했습니다")
        }
        
        let (_, response) = try await URLSession.shared.upload(for: request, from: imageData)
        
        if let httpResponse = response as? HTTPURLResponse {
            if (200...299).contains(httpResponse.statusCode) {
                print("2️⃣ Status Code: \(httpResponse.statusCode)")
                print("4️⃣ uploadImage API 종료 ========================================")
                return true
            } else {
                print("2️⃣ Failed Status Code: \(httpResponse.statusCode)")
                return false
            }
        } else {
            print("4️⃣ uploadImage API Error ========================================")
            throw NetworkError.clientError(message: "이미지를 올릴 수 없습니다.")
        }
    }
    
    /// AWS S3에 여러 이미지 업로드
    func uploadImages(presignedUrls: [String], uploadImages: [UIImage]) async throws -> [PutUploadImagesResponseDTO] {
        print("1️⃣ uploadImages API 호출 ========================================")
        var results: [PutUploadImagesResponseDTO] = []
        
        await withTaskGroup(of: (Int, Bool).self) { taskGroup in
            for (index, presignedUrl) in presignedUrls.enumerated() {
                let uploadImage = uploadImages[index]
                
                taskGroup.addTask {
                    do {
                        let result = try await self.uploadImage(presignedUrl: presignedUrl, uploadImage: uploadImage)
                        return (index, result)
                    } catch {
                        print("Error uploading image \(index + 1): \(error)")
                        return (index, false)
                    }
                }
            }
            
            for await result in taskGroup {
                results.append(PutUploadImagesResponseDTO(index: result.0, result: result.1))
                print("Result: \(result.1) with status code: \(result.0)")
            }
        }
        
        print("4️⃣ uploadImages API 완료 ========================================")
        return results
    }
}
