//
//  PhoneNumberSearchBar.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

struct PhoneNumberSearchBar: View {
    
    // MARK: - Binding Property
    
    @Binding var text: String
    
    // MARK: - View
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("전화번호 검색", text: $text)
                    .foregroundColor(.primary)
                    .fontWithLineHeight(fontLevel: .body3)
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .frame(height: 50)
            .padding(.horizontal, 16)
            .foregroundColor(.gray5)
            .background(.gray1)
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview

#Preview {
    PhoneNumberSearchBar(text: .constant(""))
}
