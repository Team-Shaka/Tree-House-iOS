//
//  NetworkErrorCode.swift
//  Treehouse
//
//  Created by 윤영서 on 5/13/24.
//

import Foundation

enum NetworkErrorCode {
    static let globalServerError = ["GLOBAL500_1"]
    
    static let globalValidationError = ["GLOBAL400_1"]
    
    static let validateNumberError = ["NCP200_1", "NCP400_1", "NCP400_2", "NCP400_3"]
    
    static let registerError = ["USER400_1",
                                 "AUTH401_1", "AUTH401_2", "AUTH401_3", "AUTH401_4", "AUTH401_5", "AUTH401_6",
                                 "AUTH403_1",
                                 "AUTH404_1",
                                 "USER404_1",
                                 "USER409_1"]
}
