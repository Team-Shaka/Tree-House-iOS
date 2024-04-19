//
//  PhoneNumberSearchBar.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

struct PhoneNumberSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("전화번호 검색", text: $text)
                    .foregroundColor(.gray5)
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
            .padding(EdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16))
            .foregroundColor(.gray5)
            .background(.gray1)
            .cornerRadius(10)
        }
    }
}

#Preview {
    PhoneNumberSearchBar(text: .constant(""))
}
