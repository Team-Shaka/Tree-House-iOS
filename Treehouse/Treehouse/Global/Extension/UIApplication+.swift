//
//  UIApplication+.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/17/24.
//

import Foundation
import UIKit

extension UIApplication {
    func hideKeyboard() {
        guard let windowScene = self.connectedScenes.first as? UIWindowScene else { return }
        guard let window = windowScene.windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }
 
extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
