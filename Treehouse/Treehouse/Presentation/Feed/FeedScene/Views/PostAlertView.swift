//
//  PostAlertView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/13/24.
//

import SwiftUI
import PopupView

struct PostAlertView: View {
        
    // MARK: - Property

    var alertContent: String
    var onCancel: () -> Void
    var onConfirm: () -> Void
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.0)
                .frame(width: 351, height: 178)
                .foregroundStyle(.gray1)
            // TODO: - ForegroundStyle white로 변경
            
            VStack(spacing: 41) {
                Text(alertContent)
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
        }
    }
}


// MARK: - Preview

#Preview {
    PostAlertView(
        alertContent: "수정한 내용을 삭제하시겠어요?",
        onCancel: {},
        onConfirm: {}
    )}
