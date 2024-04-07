//
//  UIStackView+.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/8/24.
//

import UIKit

extension UIStackView {
    
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
