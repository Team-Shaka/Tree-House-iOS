//
//  Image+.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/30/24.
//

import UIKit
import SwiftUI

enum BasicImageType {
    case profile
    case post
    
    func toImage() -> Image {
        switch self {
        case .profile: 
            return Image(.imgUser)
        case .post:
            return Image(.imgDummy2)
        }
    }
}

extension Image {
    init?(data: Data) {
        if let uiImage = UIImage(data: data) {
            self = Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
}
