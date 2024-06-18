//
//  TextFieldStateType.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/11/24.
//

import SwiftUI

enum TextFieldStateType {
    case notFocused
    case enable
    case unable
    case duplicated
    case unableLengthValid
    
    var borderColor: Color {
        switch self {
        case .notFocused:
            return .gray1
        case .enable:
            return .gray8
        case .unable, .duplicated, .unableLengthValid:
            return .error
        }
    }
    
    var fontColor: Color {
        switch self {
        case .notFocused:
            return .gray5

        case .enable, .unable, .duplicated, .unableLengthValid:
            return .grayscaleBlack
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .notFocused:
            return .gray1
        case .enable, .unable, .duplicated, .unableLengthValid:
            return .grayscaleWhite
        }
    }
}
