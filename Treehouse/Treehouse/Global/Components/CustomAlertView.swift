//
//  CustomAlertView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/4/24.
//

import SwiftUI

struct CustomAlertView: View {
    
    @Binding var isPresented: Bool
    var alertType: AlertType
    var onCancel: () -> Void
    var onConfirm: (@escaping () -> Void) -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 41) {
                Text(alertType.title)
                    .fontWithLineHeight(fontLevel: .heading4)
                
                bottomButtonSection
            }
            .padding(EdgeInsets(top: 49.0, leading: 14.0, bottom: 14.0, trailing: 14.0))
            .background(.gray1)
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
            .padding(.horizontal, 14)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.treeBlack.opacity(0.5))
    }
    
    @ViewBuilder
    var bottomButtonSection: some View {
        switch alertType {
        case .logout, .deleteAccount:
            HStack(spacing: 12) {
                Button(action: {
                    onCancel()
                    isPresented.toggle()
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
                    onConfirm {
                        isPresented.toggle()
                    }
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
        case .deletePost, .error:
            Button(action: {
                onConfirm {
//                    isPresented.toggle()
                }
            }) {
                Text("확인")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.grayscaleWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(.grayscaleBlack)
                    .border(.black)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
    }
}

//#Preview {
//    CustomAlertView(alertType: .logout, 
//                    onCancel: {},
//                    onConfirm: {}
//                )
//}

enum AlertType {
    case logout
    case deleteAccount
    case deletePost(result: ActionResult?)
    case error
    
    var title: String {
        switch self {
        case .logout:
            return "로그아웃을 하시겠습니까?"
        case .deleteAccount:
            return "정말로 회원탈퇴를 하시겠습니까?"
        case .deletePost(let result):
            switch result {
            case .success:
                return "게시글을 삭제했습니다"
            case .failure:
                return "오류가 발생했습니다"
            case .none:
                return ""
            }
        case .error:
            return "알수 없는 오류가 발생했습니다"
        }
    }
}
