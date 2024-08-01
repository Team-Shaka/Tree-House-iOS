//
//  FeedBottomSheetRowView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/20/24.
//

import SwiftUI

enum FeedBottomSheetCase {
    case isWriterOnPost
    case isReaderOnPost
    case isWriterOnComment
    case isReaderOnComment
}

struct FeedBottomSheetRowView: View {
    
    // MARK: - Property
    
    let sheetCase: FeedBottomSheetCase
    let onAction: (String) -> Void
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 50, height: 4)
                .foregroundStyle(.gray2)
                .padding(.top, 10)
            
            switch sheetCase {
            case .isWriterOnPost:
                BottomSheetButton(imageName: "ic_edit", text: "포스트 수정하기") {
                    onAction("editPost")
                }
                BottomSheetButton(imageName: "ic_delete", text: "포스트 삭제하기") {
                    onAction("deletePost")
                }
                
            case .isReaderOnPost:
                BottomSheetButton(imageName: "ic_report", text: "신고하기", textColor: .red) {
                    onAction("reportPost")
                }
                BottomSheetButton(imageName: "ic_block", text: "해당포스트 차단하기", textColor: .red) {
                    onAction("blockPost")
                }
                
            case .isWriterOnComment:
                BottomSheetButton(imageName: "ic_report", text: "신고하기", textColor: .red) {
                    onAction("reportPost")
                }
                BottomSheetButton(imageName: "ic_delete", text: "댓글 삭제하기") {
                    onAction("deleteComment")
                }
                
            case .isReaderOnComment:
                BottomSheetButton(imageName: "ic_report", text: "신고하기", textColor: .red) {
                    onAction("reportComment")
                }
            }
        }
        .padding(.bottom, 33)
        .background(.grayscaleWhite)
        .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
    }
}

struct BottomSheetButton: View {
    let imageName: String
    let text: String
    var textColor: Color = .primary
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(imageName)
                    .foregroundColor(textColor)
                
                Text(text)
                    .fontWithLineHeight(fontLevel: .body1)
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        }
    }
}

// MARK: - Preview

struct FeedBottomSheetRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedBottomSheetRowView(sheetCase: .isWriterOnPost, onAction: { _ in })
            FeedBottomSheetRowView(sheetCase: .isReaderOnPost, onAction: { _ in })
            FeedBottomSheetRowView(sheetCase: .isWriterOnComment, onAction: { _ in })
            FeedBottomSheetRowView(sheetCase: .isReaderOnComment, onAction: { _ in })
        }
        .previewLayout(.sizeThatFits)
    }
}
