//
//  String+.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/8/24.
//

import UIKit

extension String {
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars where scalar.properties.isEmoji {
            return true
        }
        return false
    }
    
    func isOnlyKorean() -> Bool {
        let pattern = "^[가-힣]*$"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    func validatePhoneNumber() -> Bool {
        let phoneRegex = "^(010\\d{8}|10\\d{8})$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: self)
    }
}
