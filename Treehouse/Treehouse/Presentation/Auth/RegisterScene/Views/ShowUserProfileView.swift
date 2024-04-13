//
//  ShowUserProfileView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/11/24.
//

import SwiftUI

struct ShowUserProfileView: View {
    
    // MARK: - State Property
    
    @State var userId: String = "younkyum"
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 24) {
                Text("\(userId)\(StringLiterals.Register.registerTitle9)")
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.black)
                
                Text(StringLiterals.Register.guidanceTitle4)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            profileView
            
            Button(action: {
                
            }) {
                Text(StringLiterals.Register.buttonTitle6)
                    .fontWithLineHeight(fontLevel: .body2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(.gray1)
                    .background(.treeBlack)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 1)
            .padding(.bottom, 12)
            
            Button(action: {
                
            }) {
                Text(StringLiterals.Register.buttonTitle12)
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(.gray6)
                    .underline()
                    .padding(EdgeInsets(top: 15, leading: 17, bottom: 19, trailing: 17))
            }
        }
        .padding(EdgeInsets(top: 66, leading: 23, bottom: 2, trailing: 24))
    }
}

// MARK: - ViewBuilder

private extension ShowUserProfileView {
    @ViewBuilder
    var profileView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.gray3, lineWidth: 1)
                .padding(.top, 56)
            
            Image(.imgUser3)
                .padding(.top, 0)
            
            VStack(spacing: 0) {
                VStack(spacing: 2) {
                    Text("멤버이름")
                        .fontWithLineHeight(fontLevel: .heading3)
                        .foregroundStyle(.black)
                    
                    Text("@\(userId)")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.gray5)
                }
                .padding(.bottom, 10)
                
                ZStack(alignment: .center) {
                        
                    captionView
                    
                    Text(StringLiterals.Register.guidacneTitel9)
                        .fontWithLineHeight(fontLevel: .body5)
                        .foregroundStyle(.treeGreen)
                        .padding(.top, 14)
                }
                .padding(.bottom, 16)
            }
            .padding(.top, 124)
        }
        .padding(.top, 48)
        .padding(.bottom, 73)
    }
    
    @ViewBuilder
    var captionView: some View {
        VStack(spacing: 0) {
            Image(.imgPolygon)
            
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundStyle(.treePale)
                .frame(height: 46)
                .padding(.horizontal, 16)
        }
    }
}

// MARK: - Preview

#Preview {
    ShowUserProfileView()
}