//
//  AuthPhoneNumAlert.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/22/24.
//

import SwiftUI

struct AuthPhoneNumAlert: View {
    
    var authState: PhoneNumberAuthState?
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 41) {
            Text(authState?.title ?? "정보 없음")
                .fontWithLineHeight(fontLevel: .heading4)
                .multilineTextAlignment(.center)

            Button(action: {
                onConfirm()
            }) {
                Text("확인")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.grayscaleWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(.grayscaleBlack)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
        }
        .padding(EdgeInsets(top: 25.0, leading: 14.0, bottom: 14.0, trailing: 14.0))
        .frame(maxWidth: .infinity)
        .background(.gray1)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
        .padding(.horizontal, 21)
    }
}

#Preview {
    AuthPhoneNumAlert(authState: .success, onConfirm: {})
}
