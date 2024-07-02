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
    
    @Environment (ViewRouter.self) var viewRouter
    @ObservedObject var viewModel: PostDetailViewModel
    
    @State private var postContent: String = ""
    @State private var textFieldState: TextFieldStateType = .notFocused
    @FocusState private var focusedField: FeedField?
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    SinglePostView(userProfileImageURL: "", sentTime: 1, postContent: "", postImageURLs: [""], postType: .DetailView)
                }
                
                feedDetailTextField
                    .onChange(of: focusedField) { _, newValue in
                        if newValue == .post {
                            textFieldState = .enable
                        } else {
                            textFieldState = .notFocused
                        }
                    }
            }
            
            if viewModel.isDeletePostPopupShowing {
                deletePostPopupView
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("게시글")
                    .font(.fontGuide(.body2))
                    .foregroundStyle(.treeBlack)
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
                            print("댓글 게시 버튼")
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
    }
    
    @ViewBuilder
    var deletePostPopupView: some View {
        Color.black.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
        
        VStack {
            Spacer()
            
            PostAlertView(
                alertContent: "작성한 포스트를 삭제하시겠어요?",
                onCancel: {
                    viewModel.isDeletePostPopupShowing = false
                },
                onConfirm: {
                    viewModel.isDeletePostPopupShowing = false
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
    PostDetailView(viewModel: PostDetailViewModel())
        .environment(ViewRouter())
}
