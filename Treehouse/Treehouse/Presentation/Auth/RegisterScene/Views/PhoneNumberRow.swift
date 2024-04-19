//
//  PhoneNumberRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

struct PhoneNumberRow: View {
    
//    var person: Person
    
    var body: some View {
        HStack(spacing: 0) {
            Image("ic_noti_member") // person.image
                .resizable()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("홍길동") // Text(person.name)
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundColor(.grayscaleBlack)
                
                Text("010-XXXX-XXXX") // Text(person.phonenumber)
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundColor(.gray5)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("초대하기")
                    .fontWithLineHeight(fontLevel: .body4)
                    .frame(width: 72, height: 32)
                    .foregroundStyle(.grayscaleWhite)
                    .background(.treeBlack)
                    .cornerRadius(16)
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    PhoneNumberRow()
}
