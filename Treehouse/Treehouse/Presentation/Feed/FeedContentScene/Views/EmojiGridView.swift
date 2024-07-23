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
    @Environment (PostViewModel.self) var postViewmodel
    @Environment (EmojiViewModel.self) var emojiViewModel
    
    @State var serachEmoji: String = ""
    @FocusState private var focusedField: Bool
    @State private var showPopover = false
    
    @State var selectedId: UUID?
    
    // MARK: - View

    var body: some View {
        VStack(spacing: 0) {
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
                                }
                                
                                Task {
                                    await emojiViewModel.createReactionComment(
                                        treehouseId: feedViewModel.currentTreehouseId ?? 0,
                                        postId: feedViewModel.currentPostId ?? 0,
                                        commentId: feedViewModel.currentCommentId ?? 0
                                    )
                                }
                            }) {
                                Text(data.unicodeEmoji)
                                    .font(.system(size: 40))
                            }
                            .disabled(selectedId != nil && selectedId != data.id)
                            .popover(isPresented: self.makeIsPresented(item: data), attachmentAnchor: .point(.center), content: {
                                ColorEmojiPopover(selectEmoji: data)
                                    .font(.system(size: 30))
                                    .presentationCompactAdaptation(.popover)
                                }
                            )
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
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
    EmojiGridView()
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
}
