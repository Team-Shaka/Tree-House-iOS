//
//  FeedView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import SwiftUI

enum FeedField {
    case post
}

enum FeedViewStateType {
    case empty
    case notEmpty
}

struct FeedView: View {
    
    // MARK: - State Property
    
    @State private var postContent: String = ""
    @State private var textFieldState: TextFieldStateType = .notFocused
    @StateObject private var photoPickerManager = PhotoPickerManager(type: .postImage)
    @State private var isPickerPresented = false
    
    @FocusState private var focusedField: FeedField?
    @FocusState private var isKeyboardShowing: Bool
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            postTextField
            
            filledFeedView
        }
        .onChange(of: focusedField) { _, newValue in
            if newValue == .post {
                textFieldState = .enable
            } else {
                textFieldState = .notFocused
            }
        }
        .sheet(isPresented: $isPickerPresented) {
            photoPickerManager.presentPhotoPicker()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - View Builder

extension FeedView {
    @ViewBuilder
    private var postTextField: some View {
        VStack(spacing: 0) {
            HStack() {
                TextField("groupname에 글쓰기...", text: $postContent, axis: .vertical)
                    .padding(EdgeInsets(top: 12.0, leading: 14.0, bottom: 12.0, trailing: 14.0))
                    .font(.fontGuide(.body5))
                    .tint(.treeGreen)
                    .foregroundColor(textFieldState.fontColor)
                    .focused($focusedField, equals: .post)
                    .keyboardType(.default)
                    .textInputAutocapitalization(.never)
                    .focused($isKeyboardShowing)
                    .frame(width: 320)
                    .lineLimit(2)
                    .background(.gray2)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button(action: {
                                isPickerPresented = true
                            }){
                                Image(.icPhoto)
                            }
                            Button(action: {
                                isKeyboardShowing = false
                            }){
                                Image(.icDelete2)
                            }
                        }
                    }
                    .padding(.leading, 16)
                                
                    Image(textFieldState == .enable ? .icReply : .icReplyUnable)
                        .padding(.trailing, 16)
            }
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            
            if !photoPickerManager.selectedImages.isEmpty {
                selectedPhotosView
            }
        }
    }
    
    @ViewBuilder
    var selectedPhotosView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(photoPickerManager.selectedImages, id: \.self) { image in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray3, lineWidth: 1))
                            .frame(width: 54, height: 54)
                        
                        Button(action: {
                            if let index = photoPickerManager.selectedImages.firstIndex(of: image) {
                                photoPickerManager.selectedImages.remove(at: index)
                            }
                        }){
                            Image(.btnImgdelete)
                        }
                        .offset(x: 10, y: -10)
                    }
                }
            }
            .padding(EdgeInsets(top: 11, leading: 16, bottom: 7, trailing: 16))
        }
    }
    
    @ViewBuilder
    func contentView(viewState: FeedViewStateType) -> some View {
        switch viewState {
        case .empty:
            emptyFeedView
        case .notEmpty:
            Text("dfdf")
        }
    }
    
    @ViewBuilder
    var emptyFeedView: some View {
        VStack(spacing: 20) {
            Image(.imgFeedempty)
            
            Text("아직 올라온 게시글이 없어요")
                .font(.fontGuide(.heading4))
                .foregroundStyle(.gray5)
        }
        .frame(height: 482)
    }
    
    @ViewBuilder
    var filledFeedView: some View {
        SinglePostView(userProfileImageURL: "", sentTime: 4, postContent: "", postImageURLs: ["", ""])
    }
}

// MARK: - Preview

#Preview {
    FeedView()
}
