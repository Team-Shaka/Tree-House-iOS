//
//  HeaderView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/30/24.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - Property
    
    var groupName: String
    
    // MARK: - Binding Property
    
    @Binding var isPresent: Bool
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image(.imgProfile)
                .frame(width: 36, height: 36)
                .padding(.leading, 16)
            
            Text(groupName)
                .fontWithLineHeight(fontLevel: .heading4)
                .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                isPresent = true
            }) {
                Image(.icChange)
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 16)
            }
        }
    }
}
