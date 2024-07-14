//
//  PhoneNumberRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/19/24.
//

import SwiftUI

struct PhoneNumberRow: View {
    
    // MARK: - Property
    
    var userInfo: UserPhoneNumberInfo
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            Image(data: userInfo.profileImage, defaultImage: .icNotiMember)
                .resizable()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(userInfo.name)
                    .font(.fontGuide(.body2))
                    .foregroundColor(.grayscaleBlack)
                
                Text(userInfo.phoneNumber)
                    .font(.fontGuide(.body5))
                    .foregroundColor(.gray5)
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text(StringLiterals.Invitation.buttonTitle2)
                    .fontWithLineHeight(fontLevel: .body5)
                    .frame(width: 72, height: 32)
                    .foregroundStyle(.grayscaleWhite)
                    .background(.treeBlack)
                    .cornerRadius(16)
            }
        }
        .padding(.vertical, 13)
    }
}

// MARK: - Preview

#Preview {
    let phoneNumbers = UserPhoneNumberInfo.phoneNumberStructDummyData
    return Group {
        PhoneNumberRow(userInfo: phoneNumbers[0])
        PhoneNumberRow(userInfo: phoneNumbers[1])
    }
}
