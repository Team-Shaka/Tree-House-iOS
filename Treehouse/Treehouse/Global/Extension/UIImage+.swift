//
//  UIImage+.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

import UIKit
import ImageIO

extension UIImage {
    static func downsample(imageData: Data, to pointSize: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, imageSourceOptions) else {
            return nil
        }

        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        print("원본 사이즈:", imageData)
        var count: CGFloat = 5
        var low: CGFloat = maxDimensionInPixels * count
        let high: CGFloat = maxDimensionInPixels * 10
        var resultImage: UIImage?
        
        while low <= high {
            let downsampleOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceThumbnailMaxPixelSize: low
            ] as CFDictionary
            
            guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
                return nil
            }
            
            let currentImage = UIImage(cgImage: downsampledImage)
            
            guard let currentImageData = currentImage.pngData() else {
                return nil
            }
            
            print(currentImageData)
            
            if currentImageData.count <= 3000000 {
                resultImage = currentImage
                count += 1
                low = maxDimensionInPixels * count
            } else {
                break
            }
        }
        return resultImage
    }
    
    func getImageBitSize() -> Int {
        if let imageData = self.pngData() {
            return imageData.count
        }
        return 0
    }
}
