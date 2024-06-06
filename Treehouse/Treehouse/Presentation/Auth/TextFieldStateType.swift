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
    
    var borderColor: Color {
        switch self {
        case .notFocused:
            return .gray1
        case .enable:
            return .gray8
        case .unable:
            return .error
        }
    }
    
    var fontColor: Color {
        switch self {
        case .notFocused:
            return .gray5
        case .enable, .unable:
            return .grayscaleBlack
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .notFocused:
            return .gray1
        case .enable, .unable:
            return .grayscaleWhite
        }
    }
}
