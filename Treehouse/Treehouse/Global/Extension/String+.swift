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
    
    // 전화번호 형식으로 포맷하는 변수
    var formatPhoneNumber: String {
        guard self.count == 11 else { return self }
        
        let firstPart = self.prefix(3)
        let secondPart = self.dropFirst(3).prefix(4)
        let thirdPart = self.dropFirst(7)
        
        return "\(firstPart)-\(secondPart)-\(thirdPart)"
    }
    
    /// 한줄에 가능한 텍스트를 출력하기 위한 메서드
    func splitCharacter() -> String {
        return self.split(separator: "").joined(separator: "\u{200B}")
    }
}
