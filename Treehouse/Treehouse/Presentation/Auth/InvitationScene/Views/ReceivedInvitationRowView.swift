//
//  ReceivedInvitationRowView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/22/24.
//

import SwiftUI

struct ReceivedInvitationRowView: View {
    
    // MARK: - Property
    
    let image: String
    let title: String
    let count: Int
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            CustomAsyncImage(url: image, type: .treehouseImage, width: 46, height: 46)
                .clipShape(Circle())
            
            Text(title)
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.grayscaleBlack)
                .padding(.leading, 19)
            
            Spacer()
            
            HStack(spacing: 2) {
                Image(.imgGroupPerson)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
                
                Text("\(count)")
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(.gray5)
            }
            .padding(.trailing, 15)
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray5)
                .frame(width: 24, height: 24)
        }
        .padding(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.gray3, lineWidth: 1)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 17)
        .background(.grayscaleWhite)
    }
}

// MARK: - Preview

#Preview {
    ReceivedInvitationRowView(image: "img_group",
                              title: "점심팟",
                              count: 20)
}
