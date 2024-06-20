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
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 50, height: 4)
                .foregroundStyle(.gray2)
                .padding(.top, 10)
            
            switch sheetCase {
            case .isWriterOnPost:
                BottomSheetButton(imageName: "ic_edit", text: "포스트 수정하기")
                BottomSheetButton(imageName: "ic_delete", text: "포스트 삭제하기")
                
            case .isReaderOnPost:
                BottomSheetButton(imageName: "ic_report", text: "신고하기", textColor: .red)
                BottomSheetButton(imageName: "ic_block", text: "해당포스트 차단하기", textColor: .red)
                
            case .isWriterOnComment:
                BottomSheetButton(imageName: "ic_delete", text: "댓글 삭제하기")
                
            case .isReaderOnComment:
                BottomSheetButton(imageName: "ic_report", text: "신고하기", textColor: .red)
            }
        }
        .frame(width: .infinity)
        .padding(.bottom, 33)
        .background(.grayscaleWhite)
        .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
    }
}

struct BottomSheetButton: View {
    let imageName: String
    let text: String
    var textColor: Color = .treeBlack
    
    var body: some View {
        HStack {
            Image(imageName)
                .foregroundColor(textColor)
            
            Text(text)
                .foregroundColor(textColor)
            
            Spacer()
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
}

// MARK: -Preview

struct FeedBottomSheetRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedBottomSheetRowView(sheetCase: .isWriterOnPost)
            FeedBottomSheetRowView(sheetCase: .isReaderOnPost)
            FeedBottomSheetRowView(sheetCase: .isWriterOnComment)
            FeedBottomSheetRowView(sheetCase: .isReaderOnComment)
        }
        .previewLayout(.sizeThatFits)
    }
}
