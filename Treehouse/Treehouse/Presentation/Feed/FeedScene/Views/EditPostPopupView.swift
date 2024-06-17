//
//  EditPostPopupView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/14/24.
//

import SwiftUI

struct EditPostPopupView: View {
    
    // MARK: - State Property
    
    @State private var isCancelPopupShowing: Bool = false
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                editPostPopupHeaderView
                
                ScrollView {
                    SinglePostView(userProfileImageURL: "", sentTime: 1, postContent: "", postImageURLs: [""])
                }
            }
            
            if isCancelPopupShowing {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    PostAlertView(
                        alertContent: "수정한 내용을 삭제하시겠어요?",
                        onCancel: {
                            self.isCancelPopupShowing = false
                        },
                        onConfirm: {
                            self.isCancelPopupShowing = false
                        }
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12.0)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                    )
                    
                    Spacer()
                }
            }
        }
    }
}

extension EditPostPopupView {
    @ViewBuilder
    var editPostPopupHeaderView: some View {
        HStack(alignment: .center) {
            Button(action: {
                self.isCancelPopupShowing.toggle()
            }) {
                Text("취소")
                    .font(.fontGuide(.body3))
                    .foregroundStyle(.gray7)
            }
            .frame(width: 44, height: 32)
            .padding(.leading, 16)
            
            Spacer()
            
            Text("게시글 수정")
                .font(.fontGuide(.body2))
                .foregroundStyle(.grayscaleBlack)
            
            Spacer()
            
            Button(action: {
                // TODO: - 완료 액션 = PATCH 서버 통신
            }) {
                Text("완료")
                    .font(.fontGuide(.body3))
                    .foregroundStyle(.grayscaleWhite)
            }
            .frame(width: 49, height: 32)
            .background(.treeGreen)
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
            .padding(.trailing, 16)
        }
        .padding(.top, 18)
    }
}

// MARK: - Preview

#Preview {
    EditPostPopupView()
}
