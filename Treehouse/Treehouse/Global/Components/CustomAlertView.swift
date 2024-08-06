//
//  CustomAlertView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/4/24.
//

import SwiftUI

struct CustomAlertView: View {
    
    var alertType: AlertType
    var onCancel: () -> Void
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 41) {
            Text(alertType.title)
                .fontWithLineHeight(fontLevel: .heading4)
            
            HStack(spacing: 12) {
                Button(action: {
                    onCancel()
                }) {
                    Text("취소")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.treeBlack)
                        .padding(EdgeInsets(top: 11.0, leading: 64.0, bottom: 11.0, trailing: 64.0))
                        .background(.grayscaleWhite)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.treeBlack, lineWidth: 1.5)
                )
                .cornerRadius(8)
                
                Button(action: {
                    onConfirm()
                }) {
                    Text("확인")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.grayscaleWhite)
                        .padding(EdgeInsets(top: 11.0, leading: 64.0, bottom: 11.0, trailing: 64.0))
                        .background(.grayscaleBlack)
                        .border(.black)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            }
        }
        .padding(EdgeInsets(top: 49.0, leading: 14.0, bottom: 14.0, trailing: 14.0))
        .background(.gray1)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}

#Preview {
    CustomAlertView(alertType: .logout, 
                    onCancel: {},
                    onConfirm: {}
                )
}


enum AlertType {
    case logout
    case deleteAccount
    
    var title: String {
        switch self {
        case .logout:
            return "로그아웃을 하시겠습니까?"
        case .deleteAccount:
            return "정말로 회원탈퇴를 하시겠습니까?"
        }
    }
}
