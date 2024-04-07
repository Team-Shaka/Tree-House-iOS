//
//  NSObject+.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/8/24.
//

import Foundation

extension NSObject {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
}
