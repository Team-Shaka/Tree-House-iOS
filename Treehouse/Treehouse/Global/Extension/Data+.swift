//
//  Data+.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/30/24.
//

import UIKit
import SwiftUI

extension Data {
    /// Data 를 Image 로 바꾸기 위한 메서드 ( 변환 실패 시 기본 Image 설정 )
    func convertDataToImage(imageType: BasicImageType) -> Image {
        if let uiImage = UIImage(data: self) {
            return Image(uiImage: uiImage)
        } else {
            return imageType.toImage()
        }
    }
}
