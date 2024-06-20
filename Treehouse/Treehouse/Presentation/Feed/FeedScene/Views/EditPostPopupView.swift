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
    @State private var postContent: String = "ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅣㅏㅣㅏㅣㅏㅣㅏㅏ"
    
    // MARK: - Property
    
    let singlePostView = SinglePostView(userProfileImageURL: "", sentTime: 1, postContent: "", postImageURLs: [""])
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                editPostPopupHeaderView
                
                ScrollView {
                    HStack(alignment: .top, spacing: 10) {
                        Image(.imgDummy2)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 36, height: 36)
                        
                        VStack(alignment: .leading) {
                            HStack(alignment: .center, spacing: 9) {
                                Text("username")
                                    .font(.fontGuide(.body2))
                                    .foregroundStyle(.treeBlack)
                                    .fontWithLineHeight(fontLevel: .body2)
                                
                                Text("branch 3분 전")
                                    .font(.fontGuide(.caption1))
                                    .foregroundStyle(.gray5)
                                    .fontWithLineHeight(fontLevel: .caption1)
                                
                                Spacer()
                            }
                            
                            DynamicHeightTextEditorView(text: $postContent)

                            singlePostView.contentImageView()
                                .opacity(0.5)
                        }
                    }
                    .padding(16)
                }
            }
            
            if isCancelPopupShowing {
                cancleEditPopupView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
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
    
    @ViewBuilder
    var cancleEditPopupView: some View {
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

// MARK: - Preview

#Preview {
    EditPostPopupView()
}
