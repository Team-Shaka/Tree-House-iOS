//
//  CommentCountView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/2/24.
//

import SwiftUI

struct CommentCountView: View {
    
    // MARK: - Property
    
    var commentCount: Int
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .foregroundColor(.gray1)
                .selectCornerRadius(radius: 10.0, corners: [.bottomLeft, .bottomRight, .topRight])
            
            HStack(spacing: 5) {
                Image(.icGreenReply)
                
                Text("\(commentCount) comments")
                    .fontWithLineHeight(fontLevel: .body4)
                    .foregroundStyle(.gray7)
            }
            .padding(.leading, 12)
        }
    }
}

#Preview {
    CommentCountView(commentCount: 0)
}
