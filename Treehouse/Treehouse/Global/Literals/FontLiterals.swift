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
            return reSize(24)
        case .heading2:
            return reSize(22)
        case .heading3:
            return reSize(20)
        case .heading4, .body1:
            return reSize(18)
        case .body2, .body3:
            return reSize(16)
        case .body4, .body5:
            return reSize(14)
        case .caption1:
            return reSize(12)
        case .caption2:
            return reSize(10)
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
        case .heading1, .heading2:
            return reSize(36)
        case .heading3:
            return reSize(28)
        case .heading4, .body1, .body2, .body3:
            return reSize(26)
        case .body4:
            return reSize(24)
        case .body5:
            return reSize(20)
        case .caption1:
            return reSize(18)
        case .caption2:
            return reSize(16)
        }
    }
    
    func reSize(_ size: CGFloat) -> CGFloat{
        return SizeLiterals.Screen.screenHeight * size / 852
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
