//
//  PostDetailView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/7/24.
//

import SwiftUI
import PopupView

struct PostDetailView: View {
    
    // MARK: - State Property
    
    @State private var postContent: String = ""
    @State private var textFieldState: TextFieldStateType = .notFocused
    @State private var isPostEditPopupShowing: Bool = false
    
    @FocusState private var focusedField: FeedField?
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    SinglePostView(userProfileImageURL: "", sentTime: 1, postContent: "", postImageURLs: [""])
                }
                
                feedDetailTextField
                    .onChange(of: focusedField) { _, newValue in
                        if newValue == .post {
                            textFieldState = .enable
                        } else {
                            textFieldState = .notFocused
                        }
                    }
                
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                // TODO: - 뒤로 가기 액션
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.treeBlack)
                                Text("게시글")
                                    .font(.fontGuide(.heading3))
                                    .foregroundStyle(.treeBlack)
                            }
                            .padding(.top, 5)
                            .padding(.bottom, 14)
                        }
                    }
            }
        }
    }
}

// MARK: - ViewBuilder

extension PostDetailView {
    @ViewBuilder
    var feedDetailTextField: some View {
        VStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray3)
            
            HStack(alignment: .bottom, spacing: 10) {
                Image(.imgDummy2)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 36, height: 36)
                    .padding(.bottom, 4)
                
                ZStack(alignment: .trailing) {
                    TextField("username에게 댓글쓰기", text: $postContent, axis: .vertical)
                        .padding(EdgeInsets(top: 12.0, leading: 14.0, bottom: 12.0, trailing: 14.0))
                        .font(.fontGuide(.body5))
                        .tint(.treeGreen)
                        .foregroundColor(textFieldState.fontColor)
                        .focused($focusedField, equals: .post)
                        .keyboardType(.default)
                        .textInputAutocapitalization(.never)
                        .lineLimit(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.gray4, lineWidth: 1)
                        )
                    
                    if textFieldState == .enable {
                        Button(action: {
                            // TODO: - 댓글 게시 API 연결
                            // TODO: - 미트벌 머튼 통해서 팝업 bool 변경
                            isPostEditPopupShowing.toggle()
                        }) {
                            Image(.icReply)
                        }
                        .padding(.trailing, 7)
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.top, 8)
            .padding(.trailing, 16)
        }
        .popup(isPresented: $isPostEditPopupShowing) {
            EditPostPopupView()
                .background(.grayscaleWhite)
                .frame(height: 790)
                .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
        } customize: {
            $0
                .type(.toast)
                .dragToDismiss(true)
                .isOpaque(true)
                .backgroundColor(.treeBlack.opacity(0.5))
        }
    }
}

// MARK: - Preview

#Preview {
    PostDetailView()
}
