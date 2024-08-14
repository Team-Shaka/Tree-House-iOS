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

@Observable
final class ImageLoader {
    var image: UIImage?
    private var url: String?
    var state: LoadState = .loading
    
    enum LoadState {
       case loading
       case success(UIImage)
       case failure
   }
    
    static func getCurrentCacheUsage() -> CacheUsage {
           let cache = URLCache.shared
           return CacheUsage(
               memoryUsage: cache.currentMemoryUsage,
               diskUsage: cache.currentDiskUsage
           )
       }
    
    init(url: String?) {
        self.url = url
    }
    
    @MainActor
    func fetch() async {
        guard let url = url, let fetchURL = URL(string: url) else {
            state = .failure
            return
        }
        
        let request = URLRequest(url: fetchURL, cachePolicy: .returnCacheDataElseLoad)
        let usage = ImageLoader.getCurrentCacheUsage()
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let image = UIImage(data: data) {
                state = .success(image)
            } else {
                state = .failure
            }
            print("메모리 캐시: \(String(format: "%.2f", usage.memoryUsageMB)) MB")
            print("디스크 캐시: \(String(format: "%.2f", usage.diskUsageMB)) MB")
        } catch {
            print("Error loading image: \(error)")
            state = .failure
        }
    }
}
