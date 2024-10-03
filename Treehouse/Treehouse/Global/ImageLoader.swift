//
//  ImageLoader.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/12/24.
//

import Foundation
import Observation
import SwiftUI

struct CacheUsage {
    let memoryUsage: Int
    let diskUsage: Int
    
    var memoryUsageMB: Double {
        return Double(memoryUsage) / (1024 * 1024)
    }
    
    var diskUsageMB: Double {
        return Double(diskUsage) / (1024 * 1024)
    }
}

enum LoadState {
    case loading
    case success(Data)
    case failure
}

@Observable
final class ImageLoader {
    static let shared = ImageLoader()
    
    private init() {}
    
    @MainActor
    func loadImage(url: String) async -> LoadState {
        guard let fetchURL = URL(string: url) else {
            return .failure
        }
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        let usage = ImageLoader.getCurrentCacheUsage()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print("메모리 캐시: \(String(format: "%.2f", usage.memoryUsageMB)) MB")
            print("디스크 캐시: \(String(format: "%.2f", usage.diskUsageMB)) MB")
            return .success(data)
        } catch {
            print("Error loading image: \(error)")
            return .failure
        }
    }
    
    static func getCurrentCacheUsage() -> (memoryUsageMB: Double, diskUsageMB: Double) {
        let cache = URLCache.shared
        let memoryUsageMB = Double(cache.currentMemoryUsage) / (1024 * 1024)
        let diskUsageMB = Double(cache.currentDiskUsage) / (1024 * 1024)
        return (memoryUsageMB, diskUsageMB)
    }
}
