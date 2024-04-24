//
//  PhoneNumberSearchBar.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

enum SearchBarStateType {
    case empty
    case notEmpty
}

struct PhoneNumberSearchBar: View {
    
    // MARK: - Binding Property
    
    @Binding var text: String
    
    // MARK: - View
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(StringLiterals.Invitation.placeholderTitle1, text: $text)
                    .foregroundColor(.primary)
                    .fontWithLineHeight(fontLevel: .body3)
                
                if text.isEmpty {
                    xmarkView(viewState: .empty)
                } else {
                    xmarkView(viewState: .notEmpty)
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 16)
            .foregroundColor(.gray5)
            .background(.gray1)
            .cornerRadius(10)
        }
    }
    
    @ViewBuilder
    func xmarkView(viewState: SearchBarStateType) -> some View {
        switch viewState {
        case .empty:
            EmptyView()
        case .notEmpty:
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PhoneNumberSearchBar(text: .constant(""))
}
