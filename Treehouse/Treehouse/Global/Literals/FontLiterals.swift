//
//  FontLiterals.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import SwiftUI

enum FontName: String {
    case PretendardSemiBold = "Pretendard-SemiBold"
    case PretendardRegular = "Pretendard-Regular"
    case PretendardMedium = "Pretendard-Medium"
}

enum FontLevel {
    case heading1
    case heading2
    case heading3
    case heading4
    
    case body1
    case body2
    case body3
    case body4
    case body5
    
    case caption1
    case caption2
}

extension FontLevel {
    var fontWeight: String {
        switch self {
        case .body1:
            return FontName.PretendardMedium.rawValue
        case .heading1, .heading2, .heading3, .heading4, .body2, .body4:
            return FontName.PretendardSemiBold.rawValue
        case .body3, .body5, .caption1, .caption2:
            return FontName.PretendardRegular.rawValue
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .heading1:
            return 24
        case .heading2:
            return 22
        case .heading3:
            return 20
        case .heading4, .body1:
            return 18
        case .body2, .body3:
            return 16
        case .body4, .body5:
            return 14
        case .caption1:
            return 12
        case .caption2:
            return 10
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .heading1, .heading2:
            return 36
        case .heading3:
            return 28
        case .heading4, .body1, .body2, .body3:
            return 26
        case .body4, .body5:
            return 24
        case .caption1:
            return 18
        case .caption2:
            return 16
        }
    }
}

extension Font {
    static func fontGuide(_ fontLevel: FontLevel) -> Font {
        return Font.custom(fontLevel.fontWeight, size: fontLevel.fontSize)
    }
    
    static func uiFontGuide(_ fontLevel: FontLevel) -> UIFont {
        return UIFont(name: fontLevel.fontWeight, size: fontLevel.fontSize)!
    }
}
