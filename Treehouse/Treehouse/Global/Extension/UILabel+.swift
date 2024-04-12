//
//  UILabel+.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/8/24.
//

import UIKit

extension UILabel {
    
    func partFontChange(targetString: String, font: UIFont, textColor: UIColor) {
        guard let existingText = self.text else {
            return
        }
        let existingAttributes = self.attributedText?.attributes(at: 0, effectiveRange: nil) ?? [:]
        let attributedStr = NSMutableAttributedString(string: existingText, attributes: existingAttributes)
        let range = (existingText as NSString).range(of: targetString)
        attributedStr.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        self.attributedText = attributedStr
    }
    
    func partColorChange(targetString: String, textColor: UIColor) {
        guard let existingText = self.text else {
            return
        }
        let existingAttributes = self.attributedText?.attributes(at: 0, effectiveRange: nil) ?? [:]
        let attributedStr = NSMutableAttributedString(string: existingText, attributes: existingAttributes)
        let range = (existingText as NSString).range(of: targetString)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
        self.attributedText = attributedStr
    }
    
    func secondColorChange(targetString: String, textColor: UIColor) {
        guard let existingText = self.text else {
            return
        }
        let firstRange = (existingText as NSString).range(of: targetString)
        let searchRange = NSRange(location: firstRange.location + 1, length: existingText.utf16.count - firstRange.location - 1)
        let secondRange = (existingText as NSString).range(of: targetString, options: .caseInsensitive, range: searchRange)
        let attributedStr = NSMutableAttributedString(string: existingText)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: secondRange)
        self.attributedText = attributedStr
    }
    
    func setLineSpacing(lineSpacing: CGFloat) {
        if let text = self.text {
            let attributedStr = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpacing
            attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                       value: style,
                                       range: NSMakeRange(0, attributedStr.length))
            self.attributedText = attributedStr
        }
    }
    
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight)
            ]
            
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func setUnderlinePartFontChange(targetString: String, font: UIFont) {
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.attributedText = attributedString
    }
}