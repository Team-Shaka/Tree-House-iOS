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
    
    @FocusState private var focusedField: FeedField?
    
    // MARK: - View
    
    var body: some View {
        VStack {
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
    }
}

// MARK: - View Builder

extension FeedView {
    @ViewBuilder
    private var postTextField: some View {
        HStack(spacing: 0) {
            Image(.imgDummy2)
                .resizable()
                .clipShape(Circle())
                .frame(width: 36, height: 36)
            
            TextField("groupname에 글쓰기...", text: $postContent)
                .font(.fontGuide(.body5))
                .padding()
                .tint(.treeGreen)
                .foregroundColor(textFieldState.fontColor)
                .focused($focusedField, equals: .post)
            
            if textFieldState == .enable {
                Image(.icUpload)
            }
        }
        .frame(height: 36)
        .padding(.leading, 16)
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
