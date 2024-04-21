//
//  PhoneNumberRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

struct PhoneNumberRow: View {
    
    // MARK: - Property
    
    var phoneNumber: PhoneNumberStruct
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            Image("ic_noti_member")
                .resizable()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(phoneNumber.name)
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundColor(.grayscaleBlack)
                
                Text(phoneNumber.phoneNumber)
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

// MARK: - Preview

#Preview {
    let phoneNumbers = PhoneNumberStruct.phoneNumberStructDummyData
    return Group {
        PhoneNumberRow(phoneNumber: phoneNumbers[0])
        PhoneNumberRow(phoneNumber: phoneNumbers[1])
    }
}
