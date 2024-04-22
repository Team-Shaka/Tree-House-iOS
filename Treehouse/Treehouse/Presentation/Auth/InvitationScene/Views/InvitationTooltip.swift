//
//  InvitationTooltip.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/22/24.
//

import SwiftUI

struct InvitationTooltip: View {
    
    // MARK: - Property
    
    private var text: String
    private var closeAction: () -> Void
    
    public init(text: String, closeAction: @escaping () -> Void) {
        self.text = text
        self.closeAction = closeAction
    }
    
    // MARK: - View
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    closeAction()
                }) {
                    Image(systemName: "xmark")
                        .frame(width: 10, height: 10)
                        .foregroundColor(.treeGreen)
                }
                .offset(y: 20)
            }
            .frame(height: 0)
            .padding(.trailing, 10)
            
            Text(text)
                .fontWithLineHeight(fontLevel: .body4)
                .foregroundStyle(Color.treeGreen)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
        }
    }
}

