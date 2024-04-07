//
//  UIViewController+.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/8/24.
//

import UIKit

extension UIViewController {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
