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
        ZStack {
            Text(text)
                .fontWithLineHeight(fontLevel: .body4)
                .foregroundStyle(Color.treePale)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        closeAction()
                    }) {
                        Image(systemName: "xmark")
                            .frame(width: 15, height: 15)
                            .foregroundColor(.treePale)
                    }
                    Spacer()
                }
            }
            .padding(.top, 10)
            .padding(.trailing, 10)
        }
    }
}

