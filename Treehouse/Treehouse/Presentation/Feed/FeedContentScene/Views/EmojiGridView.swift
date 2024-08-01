//
//  EmojiGridView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/12/24.
//

import SwiftUI

struct EmojiGridView: View {
    
    // MARK: - Property
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - State Property
    
    @Environment (FeedViewModel.self) var feedViewModel
    @Environment (EmojiViewModel.self) var emojiViewModel
    
    @State var serachEmoji: String = ""
    @FocusState private var focusedField: Bool
    @State private var showPopover = false
    
    @State var selectedId: UUID?
    
    var emojiType: EmojiListType
    var commentId: Int?
    var postId: Int?
    
    init(emojiType: EmojiListType, postId: Int) {
        self.emojiType = emojiType
        commentId = nil
        self.postId = postId
    }
    
    init(emojiType: EmojiListType, commentId: Int) {
        self.emojiType = emojiType
        self.commentId = commentId
        postId = nil
    }
    
    // MARK: - View

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 2.5)
                    .foregroundStyle(.gray4)
                    .frame(width: 50, height: 4)
                    .padding(.top, 10)
                    .padding(.bottom, 18)
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 6)
                        .frame(width:32, height: 32)
                    
                    
                    TextField("이모티콘 검색", text: $serachEmoji)
                        .padding(.vertical, 3)
                        .tint(.treeGreen)
                        .focused($focusedField)
                }
                .frame(height: 50)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray7)
                .background(.gray3)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                .padding(.bottom, 17)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(emojiViewModel.emojis) { data in
                            VStack {
                                Button(action: {
                                    if self.selectedId == data.id {
                                        self.selectedId = nil
                                        emojiViewModel.selectEmoji = nil
                                    } else {
                                        self.selectedId = data.id
                                        emojiViewModel.selectEmoji = data.unicodeEmoji
                                        
                                        Task {
                                            await emojiTappedAction()
                                        }
                                    }
                                }) {
                                    Text(data.unicodeEmoji)
                                        .font(.system(size: 40))
                                }
                                .disabled(selectedId != nil && selectedId != data.id)
                                .popover(isPresented: self.makeIsPresented(item: data), attachmentAnchor: .point(.center)) {
                                    ColorEmojiPopover(selectEmoji: data)
                                        .font(.system(size: 30))
                                        .presentationCompactAdaptation(.popover)
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
            .padding(EdgeInsets(top: 0, leading: 17, bottom: 10, trailing: 16))
        }
        .background(.gray2)
        .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
        .onTapGesture {
            selectedId = nil
            focusedField = false
            emojiViewModel.selectEmoji = nil
        }
        .task {
            emojiViewModel.loadEmojis()
        }
    }
}

// MARK: - Preview

#Preview {
    EmojiGridView(emojiType: .feedView, postId: 0)
}

// MARK: - extension function

extension EmojiGridView {
    func makeIsPresented(item: EmojiDatas) -> Binding<Bool> {
        if item.color.count != 0 {
            return .init(get: {
                return self.selectedId == item.id
            }, set: { newValue in
                if newValue {
                    self.selectedId = item.id
                } else {
                    self.selectedId = nil
                }
            })
        } else {
            return .constant(false)
        }
    }
    
    func emojiTappedAction() async {
        Task {
            switch emojiType {
            case .feedView:
                let result = await emojiViewModel.createReactionPost(
                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                    postId: postId ?? 0
                )
                
            case .detailView:
                let result = await emojiViewModel.createReactionComment(
                    treehouseId: feedViewModel.currentTreehouseId ?? 0,
                    postId: feedViewModel.currentPostId ?? 0,
                    commentId: feedViewModel.currentCommentId ?? 0
                )
            }
            
            switch emojiType {
            case .feedView:
                feedViewModel.isSelectEmojiView = false
                emojiViewModel.isSelectFeedEmojiView = false
            case .detailView:
                emojiViewModel.isSelectCommentEmojiView = false
            }
        }
    }
}
